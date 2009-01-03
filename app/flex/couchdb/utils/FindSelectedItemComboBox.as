package couchdb.utils
{
 import mx.collections.IViewCursor;
 import mx.controls.ComboBox;
 
 public class FindSelectedItemComboBox extends ComboBox
 {
	 public function FindSelectedItemComboBox()
	 {
		 super();
	 }

	 override public function set selectedItem(value:Object):void
	 {
		super.selectedItem = value;
		if (value != null && selectedIndex == -1)
		{
			// do a painful search;
			if (collection && collection.length)
			{
				var cursor:IViewCursor = collection.createCursor();
				while (!cursor.afterLast)
				{
					var obj:Object = cursor.current;
					var nope:Boolean = false;
					for (var p:String in value)
					{
						if (obj[p] !== value[p])
						{
							nope = true;
							break;
						}
					}
					if (!nope)
					{
						super.selectedItem = obj;
						return;
					}
					cursor.moveNext();
				}
			}
		}
	 }
 } 
}
