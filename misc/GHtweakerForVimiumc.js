// ==UserScript==
// @name         Vimium-c github tweaker
// @namespace    https://github.com/
// @version      1
// @description  Replace GitHub code page's textarea to div,
// @match        https://github.com/*blob*
// @run-at       document-idle
// grant window.onurlchange
// require  https://gist.github.com/raw/2625891/waitForKeyElements.js
// ==/UserScript==

(function () {
  "use strict";
  ReplaceLines();

  //   waitForKeyElements(
  //     ".react-blob-print-hide",
  //     ReplaceLines,
  //   );
  // window.addEventListener("load", function (event) {
  //   console.log("buzz All resources finished loading!");
  //   ReplaceLines();
  // });

  // if (window.onurlchange === null) {
  // feature is supported
  // window.addEventListener("urlchange", ReplaceLines);
  // }
  // const callback = (mutationsList, observer) => {
  //   ReplaceLines();
  // };
  // const observer = new MutationObserver(callback);
  // observer.observe(document, { childList: true, subtree: true });
  //const oriText = document.getElementsByClassName("react-blob-print-hide");
  // const oriText = document.getElementById("read-only-cursor-text-area");
  function ReplaceLines() {
    const regex = /[\r\n]/g;
    const textAreas = document.querySelectorAll(".react-blob-print-hide");
    for (let i = 0; i < textAreas.length; i++) {
      const oriText = textAreas[i];
      const codeLine = document.createElement("div");
      codeLine.setAttribute("style", oriText.getAttribute("style"));
      codeLine.setAttribute("id", oriText.getAttribute("id"));
      codeLine.setAttribute("class", oriText.getAttribute("class"));
      const lines = oriText.value.split(regex);
      for (let i = 0; i < lines.length; i++) {
        const lineDiv = document.createElement("div");
        if (lines[i] == "") {
          lineDiv.innerHTML = "\n";
        } else {
          lineDiv.innerHTML = lines[i];
        }
        codeLine.appendChild(lineDiv);
      }
      oriText.parentNode.replaceChild(codeLine, oriText);
    }
  }
})();
