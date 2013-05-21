window.GitHub = {};
window.GitHub.url = "https://api.github.com"
GitHub.token = null;

/* Authenticate
--------------------------------------------------------- */

GitHub.authenticate = function(username, password, options) {
  var postData;
  postData = {};
  if (options.scope != null) {
    postData.scope = options.scope;
  }
  return $.ajax({
    url: GitHub.url + "/authorizations",
    contentType: 'application/json',
    dataType: 'json',
    type: 'POST',
    data: JSON.stringify(postData),
    headers: {
      'Authorization': "Basic " + (btoa("" + username + ":" + password))
    },
    success: function(d, s, x) {
      GitHub.token = d.token;
      if (options.success != null) {
        return options.success(d, s, x);
      }
    },
    error: options.error
  });
};

/* Sync
--------------------------------------------------------- */

GitHub.sync = function(method, model, options) {
  var extendedOptions;
  extendedOptions = _.extend({
    beforeSend: function(xhr) {
      xhr.setRequestHeader('Accept', 'application/vnd.github+json');
      if (GitHub.token) {
        return xhr.setRequestHeader('Authorization', "bearer " + GitHub.token);
      }
    }
  }, options);
  return Backbone.sync(method, model, extendedOptions);
};

/* Extend
--------------------------------------------------------- */

GitHub.Model = Backbone.Model.extend({
  sync: GitHub.sync
});

GitHub.Collection = Backbone.Collection.extend({
  sync: GitHub.sync
});

GitHub.Relations = {
  ownedRepos: function(options) {
    var repos;
    repos = new GitHub.Repos;
    repos.url = typeof this.url === "function" ? this.url() : this.url;
    repos.url += "/repos";
    repos.fetch(options);
    return repos;
  },
  ownedOrgs: function(options) {
    var orgs;
    orgs = new GitHub.Organizations;
    orgs.url = typeof this.url === "function" ? this.url() : this.url;
    orgs.url += "/orgs";
    orgs.fetch(options);
    return orgs;
  }
};

/* User
--------------------------------------------------------- */

GitHub.User = GitHub.Model.extend({
  url : function() { return GitHub.url + "/users/" + this.get("login") },
  repos: GitHub.Relations.ownedRepos,
  organizations: GitHub.Relations.ownedOrgs
}, 
{
  fetch: function(login, options) {
    var user;
    user = new GitHub.User({
      login: login
    });
    user.fetch(options);
    return user;
  }
});

/* Organization
--------------------------------------------------------- */

GitHub.Organization = GitHub.Model.extend({
  url : function() { return GitHub.url + "/orgs/" + this.get("login") },
  repos: GitHub.Relations.ownedRepos
}, 
{
  fetch: function(login, options) {
    var org;
    org = new GitHub.Organization({
      login: login
    });
    org.fetch(options);
    return org;
  }
});

GitHub.Organizations = GitHub.Collection.extend({
  url: 'https://api.github.com/user/orgs',
  model: GitHub.Organization
});

/* Collaborator
--------------------------------------------------------- */

GitHub.Collaborator = GitHub.Model.extend({
  backboneClass : "Collaborator"
});

GitHub.Collaborators = GitHub.Collection.extend({
  
  model : GitHub.Collaborator,
  backboneClass : "Collaborators",

  initialize : function(models, options)
  {
    this.repo = options.repo
  },

  url : function() { return this.repo.url() + "/collaborators" }
});

/* Branch
--------------------------------------------------------- */

GitHub.Branch = GitHub.Model.extend({
  backboneClass : "Branch"
});

GitHub.Branches = GitHub.Collection.extend({
  
  model : GitHub.Collaborator,
  backboneClass : "Branches",

  initialize : function(models, options)
  {
    this.repo = options.repo
  },

  url : function() { return this.repo.url() + "/branches" }
});

/* Tree
--------------------------------------------------------- */

GitHub.Tree = GitHub.Model.extend({

  backboneClass : "Tree",

  initialize : function()
  {
    this.on("change", this.parse_collections, this);
    this.blobs = new GitHub.Blobs();
    this.trees = new GitHub.Trees();
    this.parse_collections();
  },

  parse_collections: function()
  {
    this.blobs.reset()
    this.trees.reset()

    _.each(this.get("tree"), function(o) {
      if(o.type == "blob")
      {
        this.blobs.add(new GitHub.Blob(o));
      }
      else if(o.type == "tree")
      {
        this.trees.add(new GitHub.Tree(o));
      }
    }, this);
  },

  url : function()
  { 
    return this.get("url") || this.get("repo").url() + "/git/trees/" + this.get("sha")
  }
});

GitHub.Trees = GitHub.Collection.extend({
  model : GitHub.Tree,
  backboneClass : "Trees"
});

/* Blob
--------------------------------------------------------- */

GitHub.Blob = GitHub.Model.extend({
  backboneClass : "Blob"
});

GitHub.Blobs = GitHub.Collection.extend({
  model : GitHub.Blob,
  backboneClass : "Blobs"
});

/* Repo
--------------------------------------------------------- */

GitHub.Repo = GitHub.Model.extend({
  
  backboneClass : "Repo",

  url: function()
  {
    if(this.get("url"))
      return this.get("url")
    else if(this.get("owner") && this.get("owner").login && this.get("name"))
      return GitHub.url + "/repos/" + this.get("owner").login + "/" + this.get("name")
    else
      return GitHub.url + "/repos/" + this.get("full_name")
  },

  /*these should proably work on contents
  contents : function(ref, path, options)
  {
    var sync_options = {
      url : this.url() + "/contents/" + path,
      data : $.param({ref:ref}),
      success : function(res) {

        var model;
        if(_.isArray(res))  model = new GitHub.Dir(res)
        else                model = new GitHub.File(res)

        if(options.success) options.success(model);
      },
      error : function(e1, e2, e3) {
        if(options.error) options.error(e1, e2, e3);
      }
    }

    // until my backbone pull request is merged we pass an empty model
    GitHub.sync('read', new Backbone.Model(), sync_options)
  },*/

  collaborators : function(options)
  {
    var collaborators = new GitHub.Collaborators([], {repo:this})
    collaborators.fetch(options)
    return collaborators
  },

  branches : function(options)
  {
    var branches = new GitHub.Branches([], {repo:this})
    branches.fetch(options)
    return branches
  },

  // Git Data
  // -------------------------------------------------------------

  tree : function(sha, options)
  {
    var tree = new GitHub.Tree({sha:sha, repo:this})
    tree.fetch(options)
    return tree
  }
  
  // Git Methods
  // -------------------------------------------------------------

  // TODO: commit(parent, tree, message, options)

  // TODO: remove(branch, path, options)

  // TODO: move(branch, path, newbranch, options)

  // TODO: write(branch, path, content, message, options)
}, 
{
  fetch: function(owner, name, options) {
    var repo;
    repo = new GitHub.Repo({
      full_name: owner + "/" + name
    });
    repo.fetch(options);
    return repo;
  }
});

GitHub.Repos = GitHub.Collection.extend({
  url: GitHub.url + '/user/repos',
  model: GitHub.Repo
});

/* File and Dir
--------------------------------------------------------- */

GitHub.File = GitHub.Model.extend({
  backboneClass : "File"
});

GitHub.Dir = GitHub.Collection.extend({
  model : GitHub.File,
  backboneClass : "Dir"
});

/* Current User
--------------------------------------------------------- */

GitHub.currentUser = new GitHub.User();
GitHub.currentUser.url = GitHub.url + "/user";
GitHub.currentUser.urlRoot = null;