package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	import flash.text.TextField;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author zhmq
	 */
	public class CountDownBeta extends Sprite 
	{
		private static const Item_Num:int = 10;
		private var FTFTimeVec:Vector.<TextField>;
		private var FTFNameVec:Vector.<TextField>;
		private var FTFCoolVec:Vector.<TextField>;
		private var FBtnStartVec:Vector.<MovieClip>;
		private var FCountSo:SharedObject;
		private var FBtnSave:MovieClip;
		private var FIsStartVec:Vector.<Boolean>;
		private var FCurTimeVec:Vector.<int>;
		private var FTFTips:TextField;
		
		public function CountDownBeta() 
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
			FBtnStartVec = new Vector.<MovieClip>(Item_Num);
			FIsStartVec = new Vector.<Boolean>(Item_Num);
			FCurTimeVec = new Vector.<int>(Item_Num);
			
			for (var i:int = 0; i < Item_Num; i++) 
			{
				Mc = MovieClip(getChildByName("Item_" + i));
				FTFTimeVec[i] = Mc["TF_Time"];
				FTFTimeVec[i].restrict = "0-9";
				FTFNameVec[i] = Mc["TF_Name"];
				FTFCoolVec[i] = Mc["TF_Cool"];
				FIsStartVec[i] = false;
				FBtnStartVec[i] = Mc["MC_Start"];
				FBtnStartVec[i].addEventListener(MouseEvent.CLICK, OnClick);
			}
			
			FBtnSave = MovieClip(getChildByName("MC_Save"));
			FBtnSave.addEventListener(MouseEvent.CLICK, OnSave);
			
			FTFTips = TextField(getChildByName("TF_Tips"));
			
			addEventListener(Event.ENTER_FRAME, OnEnterFrame);
		}
		
		private function InitShareObj():void
		{
			var BossObj:Object;
			var Index:int;
			var Count:int;
			var Arr:Array;
			var Str:String;
			
			FCountSo = SharedObject.getLocal("QiuqiuCount");	
			if (FCountSo.data.Arr == null)
			{				
				FCountSo.data.Arr = new Array();
				for (Index = 0; Index < Item_Num; Index++ ) 
				{
					BossObj = new Object();
					BossObj["Time"] = "0";
					BossObj["Boss"] = "BossName";
					FCountSo.data.Arr.push(BossObj);
				}
				
				FCountSo.flush();
			}
			
			Arr = FCountSo.data.Arr;
			
			for (Index = 0; Index < Item_Num; Index++) 
			{
				FTFTimeVec[Index].text = Arr[Index]["Time"];
				FTFNameVec[Index].text = Arr[Index]["Boss"];
				Str = Arr[Index]["Time"];
				FBtnStartVec[Index].visible = !(Str == null || Str == "0" || Str == "");				
			}
			
		}
		
		private function OnClick(
			E:MouseEvent):void
		{
			var Index:int;
			var Btn:MovieClip;
			
			Btn = E.target as MovieClip;
			Index = FBtnStartVec.indexOf(Btn);
			FIsStartVec[Index] = true;
			FCurTimeVec[Index] = getTimer() / 1000;			
			
			FTFTips.text = "开始计时";
		}
		
		private function OnSave(
			E:MouseEvent):void
		{
			var Index:int;
			var BossObj:Object;
			var Str:String;
			
			for (Index = 0; Index < Item_Num; Index++) 
			{
				BossObj = FCountSo.data.Arr[Index];
				BossObj["Time"] = FTFTimeVec[Index].text;
				BossObj["Boss"] = FTFNameVec[Index].text;
				Str = BossObj["Time"];
				FBtnStartVec[Index].visible = !(Str == null || Str == "0" || Str == "");
			}
			
			FCountSo.flush();
			
			FTFTips.text = "保存成功";
		}
		
		private function OnEnterFrame(
			E:Event):void
		{
			var TotalTime:int;
			var Hour:int;
			var Min:int;
			var Sec:int;
			var Index:int;
			var Str:String;
			var Time:int;
			
			for (Index = 0; Index < Item_Num; Index++) 
			{				
				if (!FIsStartVec[Index]) continue;
				Str = FTFTimeVec[Index].text;
				if (Str == null || Str == "0" || Str == "")
				{
					FTFCoolVec[Index].text = "计时结束";
					FIsStartVec[Index] = false;
					continue;
				}	
				Time = int(FCountSo.data.Arr[Index]["Time"]);
				TotalTime = FCurTimeVec[Index] + Time * 60 - int(getTimer() / 1000);
				Hour = TotalTime / 3600;
				TotalTime = (TotalTime - Hour * 3600);
				Min = TotalTime / 60;
				Sec = (TotalTime - Min * 60);
				
				FTFCoolVec[Index].text = (Hour >= 10?Hour:"0" + Hour) +":" + 
					(Min >= 10?Min:"0" + Min) + ":" + 
					(Sec >= 10?Sec:"0" + Sec);
			}
			
		}
		
		
	}

}