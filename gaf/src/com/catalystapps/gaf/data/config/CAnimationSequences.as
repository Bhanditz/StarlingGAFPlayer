package com.catalystapps.gaf.data.config
{
	/**
	 * @private
	 */
	public class CAnimationSequences
	{
		// --------------------------------------------------------------------------
		//
		// PUBLIC VARIABLES
		//
		// --------------------------------------------------------------------------
		// --------------------------------------------------------------------------
		//
		// PRIVATE VARIABLES
		//
		// --------------------------------------------------------------------------
		private var _sequences: Vector.<CAnimationSequence>;
		private var _sequencesStartDictionary: Object;
		private var _sequencesEndDictionary: Object;

		// --------------------------------------------------------------------------
		//
		// CONSTRUCTOR
		//
		// --------------------------------------------------------------------------
		public function CAnimationSequences()
		{
			this._sequences = new Vector.<CAnimationSequence>();

			this._sequencesStartDictionary = new Object();
			this._sequencesEndDictionary = new Object();
		}

		// --------------------------------------------------------------------------
		//
		// PUBLIC METHODS
		//
		// --------------------------------------------------------------------------
		public function addSequence(sequence: CAnimationSequence): void
		{
			this._sequences.push(sequence);

			if (!this._sequencesStartDictionary[sequence.startFrameNo])
			{
				this._sequencesStartDictionary[sequence.startFrameNo] = sequence;
			}

			if (!this._sequencesEndDictionary[sequence.endFrameNo])
			{
				this._sequencesEndDictionary[sequence.endFrameNo] = sequence;
			}
		}

		public function getSequenceStart(frameNo: uint): CAnimationSequence
		{
			return this._sequencesStartDictionary[frameNo];
		}

		public function getSequenceEnd(frameNo: uint): CAnimationSequence
		{
			return this._sequencesEndDictionary[frameNo];
		}

		public function getStartFrameNo(sequenceID: String): uint
		{
			var result: uint = 0;

			for each (var sequence: CAnimationSequence in this._sequences)
			{
				if (sequence.id == sequenceID)
				{
					return sequence.startFrameNo;
				}
			}

			return result;
		}
		
		public function getEndFrameNo(sequenceID: String): uint
		{
			var result: uint = 0;

			for each (var sequence: CAnimationSequence in this._sequences)
			{
				if (sequence.id == sequenceID)
				{
					return sequence.endFrameNo;
				}
			}

			return result;
		}

		public function getSecuenceByID(id: String): CAnimationSequence
		{
			for each (var sequence: CAnimationSequence in this._sequences)
			{
				if (sequence.id == id)
				{
					return sequence;
				}
			}

			return null;
		}

		// --------------------------------------------------------------------------
		//
		// PRIVATE METHODS
		//
		// --------------------------------------------------------------------------
		// --------------------------------------------------------------------------
		//
		// OVERRIDDEN METHODS
		//
		// --------------------------------------------------------------------------
		// --------------------------------------------------------------------------
		//
		// EVENT HANDLERS
		//
		// --------------------------------------------------------------------------
		// --------------------------------------------------------------------------
		//
		// GETTERS AND SETTERS
		//
		// --------------------------------------------------------------------------
		public function get sequences(): Vector.<CAnimationSequence>
		{
			return _sequences;
		}
	}
}
