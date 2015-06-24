package com.catalystapps.gaf.sound
{
	import flash.media.SoundTransform;
	import com.catalystapps.gaf.core.gaf_internal;

	import flash.events.Event;
	import flash.media.Sound;
	/** @private
	 * @author Ivan Avdeenko
	 */
	public class GAFSoundManager
	{
		private var volume: Number = 1;
		private var soundChannels: Object;
		private static var _instance: GAFSoundManager;
		
		public function GAFSoundManager(singleton: Singleton)
		{
			if (!singleton)
			{
				throw new Error("GAFSoundManager is Singleton. Use GAFSoundManager.instance or GAF.soundManager instead");
			}
		}

		public function setVolume(volume: Number): void
		{
			this.volume = volume;

			var channels: Vector.<GAFSoundChannel>;
			for (var swfName: String in soundChannels)
			{
				for (var soundID: String in soundChannels[swfName])
				{
					channels = soundChannels[swfName][soundID];
					for (var i: int = 0; i < channels.length; i++)
					{
						channels[i].soundChannel.soundTransform = new SoundTransform(volume);
					}
				}
			}
		}

		public function stopAll(): void
		{
			var channels: Vector.<GAFSoundChannel>;
			for (var swfName: String in soundChannels)
			{
				for (var soundID: String in soundChannels[swfName])
				{
					channels = soundChannels[swfName][soundID];
					for (var i: int = 0; i < channels.length; i++)
					{
						channels[i].stop();
					}
				}
			}
			soundChannels = null;
		}

		gaf_internal function play(sound: Sound, soundID: uint, soundOptions: Object, swfName: String): void
		{
			if (soundOptions["continue"]
			&&  soundChannels
			&&  soundChannels[swfName]
			&&  soundChannels[swfName][soundID])
			{
				return; //sound already in play - no need to launch it again
			}
			var soundData: GAFSoundChannel = new GAFSoundChannel(swfName, soundID);
			soundData.soundChannel = sound.play(0, soundOptions["repeatCount"], new SoundTransform(this.volume));
			soundData.addEventListener(Event.SOUND_COMPLETE, onSoundPlayEnded);
			soundChannels ||= {};
			soundChannels[swfName] ||= {};
			soundChannels[swfName][soundID] ||= new <GAFSoundChannel>[];
			Vector.<GAFSoundChannel>(soundChannels[swfName][soundID]).push(soundData);
		}

		gaf_internal function stop(soundID: uint, swfName: String): void
		{
			if (soundChannels
			&&  soundChannels[swfName]
			&&  soundChannels[swfName][soundID])
			{
				var channels: Vector.<GAFSoundChannel> = soundChannels[swfName][soundID];
				for (var i: int = 0; i < channels.length; i++)
				{
					channels[i].stop();
				}
				soundChannels[swfName][soundID] = null;
				delete soundChannels[swfName][soundID];
			}
		}

		private function onSoundPlayEnded(event: Event): void
		{
			var soundChannel: GAFSoundChannel = event.target as GAFSoundChannel;
			soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundPlayEnded);

			soundChannels[soundChannel.swfName][soundChannel.soundID] = null;
			delete soundChannels[soundChannel.swfName][soundChannel.soundID];
		}

		public static function get instance(): GAFSoundManager
		{
			_instance ||= new GAFSoundManager(new Singleton());
			return _instance;
		}
	}
}

internal class Singleton {}