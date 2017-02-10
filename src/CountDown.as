package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.net.SharedObject;
	import flash.text.TextField;
	/**
	 * ...
	 * @author zhmq
	 */
	public class CountDown extends Sprite 
	{
		private static const Item_Num:int = 10;
		private static const Tab_Num:int = 8;
		private var FTFTimeVec:Vector.<TextField>;
		private var FTFNameVec:Vector.<TextField>;
		private var FTFCoolVec:Vector.<TextField>;
		private var FCountSo:SharedObject;
		private var FBtnLeft:MovieClip;
		private var FBtnRight:MovieClip;
		private var FTFPage:TextField;
		private var FTabVec:Vector.<MovieClip>;
		public function CountDown() 
		{
			Init();
			InitShareObj();
		}
		
		private function Init():void
		{
			var Mc:MovieClip;
			FTFTimeVec = new Vector.<TextField>(Item_Num);
			FTFNameVec = new Vector.<TextField>(Item_Num);
			FTFCoolVec = new Vector.<TextField>(Item_Num);
			
			for (var i:int = 0; i < Item_Num; i++) 
			{
				Mc = MovieClip(getChildByName("Item_" + i));
				FTFTimeVec[i] = Mc["TF_Time"];
				FTFNameVec[i] = Mc["TF_Name"];
				FTFCoolVec[i] = Mc["TF_Coole"];
			}
			
			SetBtnName("MC_Left","上一页");
			SetBtnName("MC_Right","下一页");
		}
		
		private function InitShareObj():void
		{
			var TabObj:Object;
			var Index:int;
			var Count:int;
			FCountSo = SharedObject.getLocal("QiuqiuCount");	
			if (FCountSo.data == null)
			{
				FCountSo.data = new Object();	
				FCountSo.data.Arr = new Array();
				for (Index = 0; Index < Tab_Num; Index++ ) 
				{
					TabObj = new Object();
					FCountSo.data.Arr.push(TabObj);
					
				}
			}
			TabObj = FCountSo.data["Tab"];
			Count = TabObj
			for (var i:int = 0; i < Tab_Num; i++) 
			{
				
			}
			
		}
		
		private function SetBtnName(Str:String, Name:String):MovieClip
		{
			var Mc:MovieClip;
			Mc = MovieClip(getChildByName(Str));
			Mc["TF_Caption"].text = Name;
			return;
		}
		
	}

}