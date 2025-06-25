Callback functions require a shared funcdef. When they're called from this plugin, the ownership of the function (original plugin that defined it) is lost, so that must be kept in mind when designing them. For example, if a plugin registers a function for 'OnEnteredMap', it will be called with 'EzToolbox' as the executing plugin. I'm not sure of a way around this.

I made an issue to request a feature to fix this: https://github.com/openplanet-nl/issues/issues/711

An abstract class with methods that are overridden by dependent plugins does not seem to be any better in this regard, but it does significantly cut down on the code I have to write.
