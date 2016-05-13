# ApiConstraints for versioning of APIs
#
# @author [sreeraj s]
#
class ApiConstraints
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(req)
    accept = req.headers['Accept']
    @default || accept.include?("application/todoApp.v#{@version}")
  end
end
