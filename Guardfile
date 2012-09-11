guard :shell do
  roundup = File.expand_path('../vendor/roundup/roundup.sh', __FILE__)
  watch("spec/spec_helper.sh")    { |m| system("#{roundup} spec/**/*_spec.sh"); true }
  watch(%r{^(spec/.+_spec\.sh)$}) { |m| system("#{roundup} #{m[1]}"); true }
  watch(%r{^lib/(.+)\.sh$})       { |m| system("#{roundup} spec/lib/#{m[1]}_spec.sh") }
end
