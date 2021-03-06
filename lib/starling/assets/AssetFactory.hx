// =================================================================================================
//
//	Starling Framework
//	Copyright Gamua GmbH. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package starling.assets;

import openfl.utils.ByteArray;
import openfl.Vector;

/** An AssetFactory is responsible for creating a concrete instance of an asset.
 *
 *  <p>The AssetManager contains a list of AssetFactories, registered via 'registerFactory'.
 *  When the asset queue is processed, each factory (sorted by priority) will be asked if it
 *  can handle a certain AssetReference (via the 'canHandle') method. If it can, the 'create'
 *  method will be called, which is responsible for creating at least one asset.</p>
 *
 *  <p>By extending 'AssetFactory' and registering your class at the AssetManager, you can
 *  customize how assets are being created and even add new types of assets.</p>
 */

@:jsRequire("starling/assets/AssetFactory", "default")

extern class AssetFactory
{
    /** Creates a new instance. */
    public function new();

    /** Returns 'true' if this factory can handle the given reference. The default
     *  implementation checks if extension and/or mime type of the reference match those
     *  of the factory. */
    public function canHandle(reference:AssetReference):Bool;

    /** This method will only be called if 'canHandle' returned 'true' for the given reference.
     *  It's responsible for creating at least one concrete asset and passing it to 'onComplete'.
     *
     *  @param reference   The asset to be created. If a local or remote URL is referenced,
     *                     it will already have been loaded, and 'data' will contain a ByteArray.
     *  @param helper      Contains useful utility methods to be used by the factory. Look
     *                     at the class documentation for more information.
     *  @param onComplete  To be called with the name and asset as parameters when loading
     *                     is successful. <pre>function(name:String, asset:Object):void;</pre>
     *  @param onError     To be called when creation fails for some reason. Do not call
     *                     'onComplete' when that happens. <pre>function(error:String):void</pre>
     */
    public function create(reference:AssetReference, helper:AssetFactoryHelper,
                           onComplete:String->Dynamic->Void, onError:String->Void):Void;

    /** Add one or more mime types that identify the supported data types. Used by
     *  'canHandle' to figure out if the factory is suitable for an asset reference. */
    public function addMimeTypes(args:Array<String>):Void;

    /** Add one or more file extensions (without leading dot) that identify the supported data
     *  types. Used by 'canHandle' to figure out if the factory is suitable for an asset
     *  reference. */
    public function addExtensions(args:Array<String>):Void;

    /** Returns the mime types this factory supports. */
    public function getMimeTypes(out:Vector<String>=null):Vector<String>;

    /** Returns the file extensions this factory supports. */
    public function getExtensions(out:Vector<String>=null):Vector<String>;

    public var priority(get, set):Int;	//with private + @:allow I get a runtime error in AssetManager.comparePriorities
    private function get_priority():Int;
    private function set_priority(value:Int):Int;
}