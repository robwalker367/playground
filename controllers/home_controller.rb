class HomeController
  def initialize(env)
    @env = env
  end

  def call
    File.read("#{__dir__}/../views/home.html")
  end

  private

  attr_reader :env
end