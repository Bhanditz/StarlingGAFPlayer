package com.catalystapps.gaf.event
{
	import com.catalystapps.gaf.data.config.CAnimationSequence;

	import starling.events.Event;

	/** @private
	 * SequenceEvent object is dispatched into the event flow when when any sequence events occur.
	 */
	[Deprecated("use GAFMovieClip.EVENT_TYPE_SEQUENCE_START and GAFMovieClip.EVENT_TYPE_SEQUENCE_END instead")]
	public class SequenceEvent extends Event
	{
		//--------------------------------------------------------------------------
		//
		//  PUBLIC VARIABLES
		//
		//--------------------------------------------------------------------------

		/** Dispatched when playhead reached first frame of sequence */
		public static const TYPE_SEQUENCE_START: String = "typeSequenceStart";

		/** Dispatched when playhead reached end frame of sequence */
		public static const TYPE_SEQUENCE_END: String = "typeSequenceEnd";

		//--------------------------------------------------------------------------
		//
		//  PRIVATE VARIABLES
		//
		//--------------------------------------------------------------------------

		private var _sequence: CAnimationSequence;

		//--------------------------------------------------------------------------
		//
		//  CONSTRUCTOR
		//
		//--------------------------------------------------------------------------

		/**
		 * Creates an SequenceEvent object that contains information about sequence events. SequenceEvent objects are passed as parameters to event listeners.
		 */
		public function SequenceEvent(type: String, sequence: CAnimationSequence)
		{
			super(type, false, null);

			this._sequence = sequence;
		}

		//--------------------------------------------------------------------------
		//
		//  PUBLIC METHODS
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  PRIVATE METHODS
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		// OVERRIDDEN METHODS
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  EVENT HANDLERS
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  GETTERS AND SETTERS
		//
		//--------------------------------------------------------------------------

		/**
		 * Sequence data Object
		 */
		public function get sequence(): CAnimationSequence
		{
			return _sequence;
		}

	}
}
