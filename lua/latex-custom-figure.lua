local default_width = "width=0.5\\linewidth"

local function extract_figinfo(figure)
  local result = {}
  if figure.c[1].c[1].attr.attributes["width"] then
    result["width"] = figure.c[1].c[1].attr.attributes["width"].."\\linewidth"
  else
    result["width"] = default_width
  end
  result["label"] = figure.attr.identifier
  result["src"] = figure.c[1].c[1].src
  result["caption"] = figure.c[1].c[1].caption[1].text
  return result
end

local function get_latex_fig(figinfo)
  return [[
\begin{figure}[t!b!hp]
  \centering
  \hypertarget{]]..figinfo["label"]..[[}{%
    \caption{]]..figinfo["caption"].."}\\label{"..figinfo["label"]..[[}
    \includegraphics[]]..figinfo["width"].."]{"..figinfo["src"]..[[}
  }
\end{figure}]]
end

function Figure(elem)
  local myfig = get_latex_fig(extract_figinfo(elem))
  elem = pandoc.RawInline('latex', myfig)
  return elem
end
