// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import flash.events.Event;

	public class ViewMovieEvent extends Event
	{
		
		public static const VIEW_MOVIE: String = "viewMovie"
		
		public function ViewMovieEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		
		override public function clone():Event
        {
            return new ViewMovieEvent(this.type, this.bubbles, this.cancelable );
        }
	}
	
}