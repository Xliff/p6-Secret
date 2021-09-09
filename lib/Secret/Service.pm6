use v6.c;

use NativeCall;

use Secret::Raw::Types;
use Secret::Raw::Service;

use GLib::GList;
use GLib::Variant;
use GIO::DBus::Proxy;

our subset SecretServiceAncestry is export of Mu
  where SecretService | GDBusProxyAncestry;

class Secret::Service is GIO::DBus::Proxy {
  has SecretService $!ss;

  multi method new (
    Int()                   $flags        =  0,
    GCancellable()          $cancellable  =  GCancellable,
    CArray[Pointer[GError]] $error        =  gerror,
                            :$sync        is required
  ) {
    self.get_sync($flags, $cancellable, $error);
  }

  multi method new (
    Str()                   $service_bus_name,
    Int()                   $flags,
    GCancellable()          $cancellable       = GCancellable,
    CArray[Pointer[GError]] $error             = gerror,
                            :$open             is required
  ) {
    self.open_sync($service_bus_name, $flags, $cancellable, $error);
  }

  proto method clear (|)
  { * }

  multi method clear (
    SecretSchema() $schema,
    GHashTable()   $attributes,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $schema,
      $attributes,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method clear (
    SecretSchema() $schema,
    GHashTable()   $attributes,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    secret_service_clear(
      $!ss,
      $schema,
      $attributes,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method clear_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so secret_service_clear_finish($!ss, $result, $error);
    set_error($error);
    $rv;
  }

  method clear_sync (
    SecretSchema()          $schema,
    GHashTable()            $attributes,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    so secret_service_clear_sync(
      $!ss,
      $schema,
      $attributes,
      $cancellable,
      $error
    );
  }

  method disconnect {
    secret_service_disconnect();
  }

  proto method ensure_session (|)
  { *}

  multi method ensure_session (
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method ensure_session (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    secret_service_ensure_session($!ss, $cancellable, &callback, $user_data);
  }

  method ensure_session_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so secret_service_ensure_session_finish($!ss, $result, $error);
    set_error($error);
    $rv;
  }

  method ensure_session_sync (
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so secret_service_ensure_session_sync($!ss, $cancellable, $error);
    set_error($error);
    $rv;
  }

  proto method get (|)
  { * }

  multi method get (
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method get (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    secret_service_get($!ss, $cancellable, &callback, $user_data);
  }

  method get_collection_gtype {
    secret_service_get_collection_gtype($!ss);
  }

  method get_collections ( :$raw = False, :$glist = False ) {
    returnGList(
      secret_service_get_collections($!ss),
      $raw,
      $glist,
      SecretCollection,
      Secret::Collection
    );
  }

  method get_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $secret-service = secret_service_get_finish($result, $error);
    set_error($error);
    $secret-service ?? self.bless( :$secret-service ) !! Nil;
  }

  method get_flags {
    secret_service_get_flags($!ss);
  }

  method get_item_gtype {
    secret_service_get_item_gtype($!ss);
  }

  method get_session_algorithms {
    secret_service_get_session_algorithms($!ss);
  }

  method get_sync (
    Int()                   $flags        = 0,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    my SecretServiceFlags $f = $flags;

    my $secret-service = secret_service_get_sync($f, $cancellable, $error);

    $secret-service ?? self.bless( :$secret-service ) !! Nil;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &secret_service_get_type, $n, $t );
  }

  proto method load_collections (|)
  { * }

  multi method load_collections (
                   &callback,
    gpointer       $user_data   = gpointer,
    GCancellable() $cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method load_collections (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    secret_service_load_collections($!ss, $cancellable, &callback, $user_data);
  }

  method load_collections_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so secret_service_load_collections_finish($!ss, $result, $error);
    set_error($error);
    $rv;
  }

  method load_collections_sync (
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so secret_service_load_collections_sync(
      $!ss,
      $cancellable,
      $error
    );
    $rv;
  }

  proto method lock (|)
  { * }

  multi method lock (
    GList()        $objects,
                   &callback,
    gpointer       $user_data   = gpointer,
    GCancellable() $cancellable = GCancellable
  ) {
    samewith($objects, $cancellable, &callback, $user_data);
  }
  multi method lock (
    GList()        $objects,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    secret_service_lock($!ss, $objects, $cancellable, &callback, $user_data);
  }

  method lock_finish (
    GAsyncResult()          $result,
    GList()                 $locked,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    secret_service_lock_finish($!ss, $result, $locked, $error);
  }

  proto method lock_sync (|)
  { * }

  multi method lock_sync (
    Secret::Service:U:
    GList()                  $objects,
    GList()                  $locked,
    CArray[Pointer[GError]]  $error        = gerror,
    GCancellable()           :$cancellable = GCancellable
  ) {
    secret_service_lock_sync(
      SecretService,
      $objects,
      $cancellable,
      $locked,
      $error
    );
  }
  multi method lock_sync (
    GList()                  $objects,
    GList()                  $locked,
    CArray[Pointer[GError]]  $error        = gerror,
    GCancellable()           :$cancellable = GCancellable
  ) {
    samewith($objects, $cancellable, $locked, $error);
  }
  multi method lock_sync (
    GList                   $objects,
    GCancellable            $cancellable,
    GList                   $locked,
    CArray[Pointer[GError]] $error
  ) {
    secret_service_lock_sync($!ss, $objects, $cancellable, $locked, $error);
  }

  proto method lookup (|)
  { * }

  multi method lookup (
    SecretSchema() $schema,
    GHashTable()   $attributes,
                   &callback,
    gpointer       $user_data   = gpointer,
    GCancellable() $cancellable = GCancellable
  ) {
    samewith($schema, $attributes, $cancellable, &callback, $user_data);
  }
  multi method lookup (
    SecretSchema() $schema,
    GHashTable()   $attributes,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    secret_service_lookup(
      $!ss,
      $schema,
      $attributes,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method lookup_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror,
                            :$raw    = False
  ) {
    clear_error;
    my $sv = returnObject(
      secret_service_lookup_finish($!ss, $result, $error),
      $raw,
      SecretValue,
      Secret::Value
    );
    set_error($error);
    $sv;
  }

  method lookup_sync (
    SecretSchema()          $schema,
    GHashTable()            $attributes,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror,
                            :$raw         = False
  ) {
    returnObject(
      secret_service_lookup_sync(
        $!ss,
        $schema,
        $attributes,
        $cancellable,
        $error
      ),
      $raw,
      SecretValue,
      Secret::Value
    );
  }

  proto method open (|)
  { * }

  multi method open (
    Str()          $service_bus_name,
    Int()          $flags,
                   &callback,
    gpointer       $user_data         = gpointer,
    GCancellable() :$cancellable      = GCancellable
  ) {
    samewith($service_bus_name, $flags, $cancellable, &callback, $user_data);
  }
  multi method open (
    Str()          $service_bus_name,
    Int()          $flags,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    my SecretServiceFlags $f = $flags;

    secret_service_open(
      $!ss,
      $service_bus_name,
      $f,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method open_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error  = gerror
  ) {
    clear_error;

    my $secret-service = secret_service_open_finish($result, $error);

    $secret-service ?? self.bless( :$secret-service ) !! Nil;
  }

  method open_sync (
    Str()                   $service_bus_name,
    Int()                   $flags,
    GCancellable()          $cancellable       = GCancellable,
    CArray[Pointer[GError]] $error             = gerror
  ) {
    my SecretServiceFlags $f = $flags;

    my $secret-service = secret_service_open_sync(
      $!ss,
      $service_bus_name,
      $f,
      $cancellable,
      $error
    );

    $secret-service ?? self.bless( :$secret-service ) !! Nil;
  }

  proto method prompt (|)
  { * }

  multi method prompt (
    SecretPrompt() $prompt,
    Int()          $return_type,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable,
                   :$raw         = False
  ) {
    samewith($prompt, $return_type, $cancellable, &callback, $user_data);
  }
  multi method prompt (
    SecretPrompt() $prompt,
    Int()          $return_type,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    my GVariantType $r = $return_type;

    secret_service_prompt(
      $!ss,
      $prompt,
      $return_type,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method prompt_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror,
                            :$raw    = False
  ) {
    returnObject(
      secret_service_prompt_finish($!ss, $result, $error),
      $raw,
      GVariant,
      GLib::Variant
    );
  }

  proto method prompt_sync (|)
  { * }

  multi method prompt_sync (
    SecretPrompt()          $prompt,
    Int()                   $return_type,
    CArray[Pointer[GError]] $error         = gerror,
    GCancellable()          :$cancellable  = GCancellable,
                            :$raw          = False,
  ) {
    samewith(
      $prompt,
      $cancellable,
      $return_type,
      $error,
      :$raw
    );
  }
  multi method prompt_sync (
    SecretPrompt()          $prompt,
    GCancellable()          $cancellable,
    Int()                   $return_type,
    CArray[Pointer[GError]] $error,
                            :$raw         = False
  ) {
    my GVariantType $r = $return_type;

    returnObject(
      secret_service_prompt_sync(
        $!ss,
        $prompt,
        $cancellable,
        $r,
        $error
      ),
      $raw,
      GVariant,
      GLib::Variant
    );
  }

  proto method search (|)
  { * }

  multi method search (
    SecretSchema() $schema,
    GHashTable()   $attributes,
    Int()          $flags,
                   &callback,
    gpointer       $user_data,
    GCancellable() :$cancellable
  ) {
    samewith($schema, $attributes, $flags, $cancellable, &callback, $user_data);
  }
  multi method search (
    SecretSchema() $schema,
    GHashTable()   $attributes,
    Int()          $flags,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    my SecretSearchFlags $f = $flags;

    secret_service_search(
      $!ss,
      $schema,
      $attributes,
      $f,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method search_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror,
                            :$raw    = False,
                            :$glist  = False

  ) {
    clear_error;
    my $sil = returnGList(
      secret_service_search_finish($!ss, $result, $error),
      $raw,
      $glist,
      SecretItem,
      Secret::Item;
    );
    set_error($error);
    $sil;
  }

  method search_sync (
    SecretSchema()          $schema,
    GHashTable()            $attributes,
    Int()                   $flags       = 0,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror,
                            :$raw        = False,
                            :$glist      = False
  ) {
    my SecretSearchFlags $f = $flags;

    returnGList(
      secret_service_search_sync(
        $!ss,
        $schema,
        $attributes,
        $f,
        $cancellable,
        $error
      ),
      $raw,
      $glist,
      SecretItem,
      Secret::Item
    );
  }

  proto method set_alias (|)
  { * }

  multi method set_alias (
    Str()              $alias,
    SecretCollection() $collection,
                       &callback,
    gpointer           $user_data = gpointer,
    GCancellable()     $cancellable = GCancellable
  ) {
    samewith($alias, $collection, $cancellable, &callback, $user_data);
  }
  multi method set_alias (
    Str()              $alias,
    SecretCollection() $collection,
    GCancellable()     $cancellable,
                       &callback,
    gpointer           $user_data
  ) {
    secret_service_set_alias(
      $!ss,
      $alias,
      $collection,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method set_alias_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error
  ) {
    secret_service_set_alias_finish($!ss, $result, $error);
  }

  method set_alias_sync (
    Str()                   $alias,
    SecretCollection()      $collection,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $rv = so secret_service_set_alias_sync(
      $!ss,
      $alias,
      $collection,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method store (|)
  { * }

  multi method store (
    SecretSchema() $schema,
    GHashTable()   $attributes,
    Str()          $collection,
    Str()          $label,
    SecretValue()  $value,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $schema,
      $attributes,
      $collection,
      $label,
      $value,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method store (
    SecretSchema() $schema,
    GHashTable()   $attributes,
    Str()          $collection,
    Str()          $label,
    SecretValue()  $value,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    secret_service_store(
      $!ss,
      $schema,
      $attributes,
      $collection,
      $label,
      $value,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method store_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so secret_service_store_finish($!ss, $result, $error);
    set_error($error);
    $rv;
  }

  method store_sync (
    SecretSchema()          $schema,
    GHashTable()            $attributes,
    Str()                   $collection,
    Str()                   $label,
    SecretValue()           $value,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so secret_service_store_sync(
      $!ss,
      $schema,
      $attributes,
      $collection,
      $label,
      $value,
      $cancellable,
      $error
    );
    set_error($error);
  }

  proto method unlock (|)
  { * }

  multi method unlock (
    GList()        $objects,
                   &callback,
    gpointer       $user_data   = gpointer,
    GCancellable() $cancellable = GCancellable
  ) {
    samewith($objects, $cancellable, &callback, $user_data);
  }
  multi method unlock (
    GList()        $objects,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    secret_service_unlock($!ss, $objects, $cancellable, &callback, $user_data);
  }

  multi method unlock_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error    =  gerror,
                            :$raw     =  False,
                            :$glist   =  False
  ) {
    samewith($result, $, $error, :$raw, :$glist)
  }
  multi method unlock_finish (
    GAsyncResult()          $result,
                            $unlocked is rw,
    CArray[Pointer[GError]] $error    =  gerror,
                            :$raw     =  False,
                            :$glist   =  False
  ) {
    (my $gl = CArray[GList])[0] = GList;

    clear_error;
    # Sinking count of elements unlocked, as that is still available via $gl
    secret_service_unlock_finish($!ss, $result, $gl, $error);
    set_error($error);

    returnGList(
      $unlocked = ppr($gl),
      $raw,
      $glist,
      GDBusProxy,
      GIO::DBus::Proxy
    );
  }

  proto method unlock_sync (|)
  { * }

  multi method unlock_sync (
    GList                   $objects,
    CArray[Pointer[GError]] $error        = gerror,
    GCancellable            :$cancellable = GCancellable,
                            :$raw         =  False,
                            :$glist       =  False,
                            :$seq         =  True
  ) {
    samewith($objects, $cancellable, $, $error, :$raw, :$glist, :$seq);
  }
  multi method unlock_sync (
    GList                   $objects,
    GCancellable            $cancellable,
                            $unlocked    is rw,
    CArray[Pointer[GError]] $error       =  gerror,
                            :$raw        =  False,
                            :$glist      =  False,
                            :$seq        =  True
  ) {
    (my $gl = CArray[GList])[0] = GList;

    clear_error;
    # Sinking count of elements unlocked, as that is still available via $gl
    secret_service_unlock_sync($!ss, $objects, $cancellable, $gl, $error);
    set_error($error);

    returnGList(
      $unlocked = ppr($gl),
      $raw,
      $glist,
      GDBusProxy,
      GIO::DBus::Proxy,
      :$seq
    );
  }
}
