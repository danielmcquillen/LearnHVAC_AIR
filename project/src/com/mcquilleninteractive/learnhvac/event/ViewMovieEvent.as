// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class ViewMovieEvent extends CairngormEvent{
		
		public static var EVENT_VIEW_MOVIE: String = "viewMovie"
		
		public function ViewMovieEvent(){
	      	super( EVENT_VIEW_MOVIE )
     	}
     	
     	override public function clone() : Event{
			return new ViewMovieEvent()
		}		
		
	}
	
}