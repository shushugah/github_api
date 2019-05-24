module RepositoriesHelper
  def repo_link(repo)
    name = repo['full_name']

    link_to name, "https://github.com/#{name}"
  end
end
