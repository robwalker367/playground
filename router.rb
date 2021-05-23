class Router
  def initialize(env)
    @env = env
  end

  def dispatch
    if File.file?(path)
      file_at_path
    else
      file_not_found
    end
  end

  private

  attr_reader :env

  def path
    "./public/#{env["PATH_INFO"]}"
  end

  def file_at_path
    File.read(path)
  end

  def file_not_found
    File.read('./public/not_found.html')
  end
end
