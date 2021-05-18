// Author:  Michael Mathews
// Date:    May 2021
// finds and highlights on the DOM the elements with that attribute.
// usage: showByAttr("data-test");

function showByAttr(attr) 
{
    let list = document.querySelectorAll('['.concat(attr).concat(']'));
    for(i=0;i<list.length;i++)
    {
        list[i].style.backgroundColor = "#FDFF47";
    }
}
