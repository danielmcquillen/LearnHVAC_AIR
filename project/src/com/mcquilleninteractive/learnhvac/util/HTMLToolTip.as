// ActionScript file
package com.mcquilleninteractive.learnhvac.util
{
  import mx.controls.ToolTip;

  public class HTMLToolTip extends ToolTip
  {
    override protected function commitProperties():void
    {
      super.commitProperties();
  
      textField.htmlText = text
    }
  }
}