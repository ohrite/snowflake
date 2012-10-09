
require 'benchmark'

roundup = File.expand_path('../vendor/roundup/roundup.sh', __FILE__)
runner = Proc.new do |spec_path|
  passed = false
  time = Benchmark.measure {
    passed = system("#{roundup} #{spec_path}")
  }.real.round(3)
  n "Ran #{spec_path} in #{time}s", "Roundup", passed ? :success : :failed
  passed
end

guard :shell do
  watch(%r{^(spec/.+_spec\.sh)$}) { |m| runner.call(m[1]) }
  watch(%r{^lib/(.+)\.sh$})       { |m| runner.call("spec/lib/#{m[1]}_spec.sh") }
end
