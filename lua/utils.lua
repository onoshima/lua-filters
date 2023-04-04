local inlinesToStrings = function(inlines)
  local res = ""
  for i = 1, #inlines do
    if inlines[i].t == "Str" then
      res = res .. inlines[i].text
    elseif inlines[i].t == "Space" then
      res = res .. " "
    elseif inlines[i].t == "SoftBreak" then
      res = res .. " "
    elseif inlines[i].t == "Math" then
      res = res .. "$" .. inlines[i].text .. "$"
    end
  end
  return res
end
