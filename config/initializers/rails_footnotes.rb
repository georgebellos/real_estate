if defined?(Footnotes) && Rails.env.development?
  Footnotes.run!
  Footnotes::Filter.prefix = 'mvim://open?url=file://%s&line=%d&column=%d'
  Footnotes::Filter.multiple_notes = true
end
