require './lib/site_config'

class Builder
  def initialize(repo_name, config_file = nil, folder_prefix = ENV['HOME'])
    @repo_name = repo_name
    @folder_prefix = folder_prefix
    config = SiteConfig.new(config_file)
    @options = OpenStruct.new(config.fetch(repo_name))
  end

  def update
    begin
      fetch_repo
      build_site
    rescue => error
      # ¯\_(ツ)_/¯
      STDERR.write("#{error.class.to_s}: #{error.message}\n")
    end
  end

  private

  def fetch_repo
    # Get the repo.
    repo = Rugged::Repository.new("#{@folder_prefix}/#{@options.source}")

    # Fetch the changes.
    remote = repo.remotes['origin']
    remote.fetch()

    # Merge the changes.
    branch = repo.branches['origin/master']
    repo.checkout_tree(branch.target)
    repo.references.update(repo.head.resolve, branch.target_id)

    # Clean the index.
    repo.reset('origin/master', :hard)
  end

  def build_site
    # Get the options from the site config and the options.
    custom_options = SafeYAML.load_file(
      "#{@folder_prefix}/#{@options.source}/_config.yml").merge({
        'source'      => "#{@folder_prefix}/#{@options.source}",
        'destination' => "#{@folder_prefix}/#{@options.destination}",
      })

      # Generate the site.
      options = Jekyll::Configuration::DEFAULTS.merge(custom_options)
      site = Jekyll::Site.new(options)
      Jekyll::Commands::Build.build(site, options)
  end
end
