require 'rake/testtask'

Rake::TestTask.new do |t|
	t.libs.push "lib"
	t.test_files = FileList['lib/*', 'spec/*_spec.rb']
	t.verbose = true
end
