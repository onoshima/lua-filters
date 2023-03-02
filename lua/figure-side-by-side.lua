local function extract_img_info(image)
  local result = {}
  result["label"] = image.identifier
  result["src"] = image.src
  result["caption"] = image.caption[1].text
  return result
end

local function make_latexfig(img1info, img2info)
  return [[
\begin{figure}[htbp]
  \centering
  \begin{minipage}[b]{0.45\columnwidth}
    \centering
    \caption{]]..img1info["caption"].."}\\label{"..img1info["label"]..[[}
    \includegraphics[keepaspectratio, width=\columnwidth]{]]..img1info["src"]..[[}
  \end{minipage}
  \begin{minipage}[b]{0.45\columnwidth}
    \centering
    \caption{]]..img2info["caption"].."}\\label{"..img2info["label"]..[[}
    \includegraphics[keepaspectratio, width=\columnwidth]{]]..img2info["src"]..[[}
  \end{minipage}
\end{figure}]]
end

function Para(elem)
  if not(#elem.c == 1) then
    for i = 1, #elem.c-1 do
      if (elem.c[i].t == 'Image' and elem.c[i+1].t == 'Image') then
        local img1info = extract_img_info(elem.c[i])
        local img2info = extract_img_info(elem.c[i+1])
        elem.c[i] = pandoc.RawInline('latex', make_latexfig(img1info, img2info))
        table.remove(elem.c, i+1)
      end
    end
    return elem
  end
end
