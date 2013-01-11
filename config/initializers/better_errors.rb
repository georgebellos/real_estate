if defined?(BetterErrors) && Rails.env.development?
  BetterErrors.editor = Proc.new{|file, line| "mvim://open/?url=file://#{URI.escape file}&line=#{line}"}
end
