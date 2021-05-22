class Router
  def initialize(env)
    @env = env
  end

  def dispatch
    if File.file?(controller_path)
      controller_output
    else
      not_found
    end
  end

  private

  attr_reader :env

  ROUTE_MAP = {
    "/" => "home_controller"
  }

  def controller_path
    "./controllers/#{controller}.rb"
  end

  def controller
    ROUTE_MAP[env["PATH_INFO"]]
  end

  def controller_output
    require_relative controller_path
    controller_klass.new(env).call
  end


  def controller_klass
    Kernel.const_get(
      controller.split("_").map(&:capitalize).join('')
    )
  end

  def not_found
    File.read('./views/not_found.html')
  end
end
