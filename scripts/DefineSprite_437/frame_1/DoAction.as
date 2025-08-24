stop();
var inputname = _root.savedata.playername;
if(inputname == undefined)
{
   inputname = "";
}
input_txt.text = inputname;
input_txt.restrict = "A-Z a-z 0-9";
Selection.setFocus("input_txt");
