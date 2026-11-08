;; extends

; Keep environment commands above the broad math highlight (priority 100).
((begin
  command: _ @module)
  (#set! priority 110))

((end
  command: _ @module)
  (#set! priority 110))
