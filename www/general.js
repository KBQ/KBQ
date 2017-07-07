$(function (){
    $("div.delParentClass").parent().removeClass("col-sm-8").addClass("col-sm-12");

/* In addClass you can specify the class of the div that you want. In this example, 
I make use of a standard Bootstrap class to change the width of the tabset: col-sm-12. 
If you want the tabset to be smaller use: col-sm-11, col-sm-10, ... or add
and create your own class. */

});