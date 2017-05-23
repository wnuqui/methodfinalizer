require 'rubygems'
require 'hoe'
require 'lib/methodfinalizer'

Hoe.new('methodfinalizer', OOP::Concepts::FinalMethod::FINAL_METHOD_VERSION) do |p|
  p.rubyforge_name = 'methodfinalizer'
  p.developer('Wilfrido T. Nuqui Jr.', 'dofreewill22@gmail.com')
end

# instead of 'rake/rdoctask':
require 'hanna/rdoctask'

desc "Generate RDoc documentation for the 'methodfinalizer' gem."
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_files.include('README.txt', 'History.txt', 'LICENSE.txt').
    include('lib/**/*.rb').
    exclude('lib/final_method/final_method_exceptions.rb').
    exclude('lib/final_method/final_method_version.rb')

  rdoc.main = "README.txt" # page to start on
  rdoc.title = "methodfinalizer documentation"

  rdoc.rdoc_dir = 'doc' # rdoc output folder
end
