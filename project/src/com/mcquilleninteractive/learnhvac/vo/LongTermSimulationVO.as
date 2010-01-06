// ActionScript file
package  com.mcquilleninteractive.learnhvac.vo 
{
	import com.adobe.cairngorm.vo.IValueObject;
	import com.mcquilleninteractive.learnhvac.util.Conversions;
	import com.mcquilleninteractive.learnhvac.util.Logger;

	public class LongTermSimulationVO implements IValueObject
	{
		
		public var runID:String  //corresponds to dataModel ID (for graphing SPARK or EPlus)		
		public var currUnits:String = "IP"
		
		
		protected var _areaPerPerson:Number
		public var maxPeople:Number
		
		public var massLevel:String
		
		
		public function LongTermSimulationVO()
		{
			
		}
		
					
		
	}
}
