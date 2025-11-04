extends Node

class_name ResourceManager

var _loaded_resources = {}
var _resource_queue = []
var _is_loading = false

signal resource_loaded(path: String, resource: Resource)
signal all_resources_loaded

func _ready():
    print("📦 ResourceManager initialized")

func preload_resource(path: String) -> void:
    if not path in _loaded_resources and not path in _resource_queue:
        _resource_queue.append(path)
        _process_queue()

func _process_queue() -> void:
    if _is_loading or _resource_queue.empty():
        return
    
    _is_loading = true
    var path = _resource_queue[0]
    
    if ResourceLoader.exists(path):
        var resource = ResourceLoader.load(path)
        if resource:
            _loaded_resources[path] = resource
            print("✓ Resource loaded: " + path)
            resource_loaded.emit(path, resource)
        else:
            push_error("❌ Failed to load resource: " + path)
    
    _resource_queue.remove_at(0)
    _is_loading = false
    
    if _resource_queue.empty():
        print("✓ All resources loaded")
        all_resources_loaded.emit()
    else:
        _process_queue()

func get_resource(path: String) -> Resource:
    if path in _loaded_resources:
        return _loaded_resources[path]
    return null

func unload_resource(path: String) -> void:
    if path in _loaded_resources:
        _loaded_resources.erase(path)
        print("🗑️ Resource unloaded: " + path)

func cleanup_unused_resources() -> void:
    var to_remove = []
    
    for path in _loaded_resources:
        if _loaded_resources[path].get_reference_count() <= 1:
            to_remove.append(path)
    
    for path in to_remove:
        unload_resource(path)
    
    print("🧹 Cleaned up " + str(to_remove.size()) + " unused resources")
