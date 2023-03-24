
local function make_latex_code(code_content, language, caption, label)
  return [[
\begin{lstlisting}[language=]].. language ..", caption=".. caption ..", label=" .. label ..[[]
]]..code_content..[[

\end{lstlisting}]]
end

function Blocks(elem)
  local label = ""
  local caption = ""
  local language = ""
  local code_content =""
  local code_block_index = {}
  for i = 1, #elem do
    --print(elem[i].t)
    if elem[i].t == "CodeBlock" then
      label = elem[i].identifier
      caption = elem[i].attr.attributes.caption
      language = elem[i].attr.classes[1]
      code_content = elem[i].text
      elem[i] = pandoc.RawBlock("latex", make_latex_code(code_content, language, caption, label))
      code_block_index[#code_block_index + 1] = i -- 前後の不要なものを削除するためindexを記録
    end
  end
  --[[
    コードブロックの2つ前に//begin{codelisting}
    1つ前に//caption{}
    1つ後に//end{codelisting}が加わるが不要なので削除
  ]]--
  if not(#code_block_index == 0) then
    for i = #code_block_index, 1, -1 do
      elem:remove(code_block_index[i]+1)
      elem:remove(code_block_index[i]-1)
      elem:remove(code_block_index[i]-2)
    end
  end
  return(elem)
end
