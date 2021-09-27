use v6.c;

use NativeCall;
use Method::Also;

use Secret::Raw::Types;
use Secret::Raw::Paths;
use Secret::Raw::Service;

use GLib::GList;
use GLib::Variant;
use GIO::DBus::Proxy;

our subset SecretServiceAncestry is export of Mu
  where SecretService | GDBusProxyAncestry;

class Secret::Service is GIO::DBus::Proxy {
  has SecretService $!ss is implementor;

  submethod BUILD (
    :initable-object( :$secret-service ),
    :$init,
    :$cancellable
  ) {
    self.setSecretService(
      $secret-service,
      :$init,
      :$cancellable
    ) if $secret-service;
  }

  method setSecretService(
    SecretServiceAncestry $_,
                          :$init,
                          :$cancellable
  ) {
    my $to-parent;

    $!ss = do {
      when SecretService {
        $to-parent = cast(GDBusProxy, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(SecretService, $_);
      }
    }

    self.setGDBusProxy($to-parent, :$init, :$cancellable);
  }

  method Secret::Raw::Structs::SecretService
    is also<SecretService>
  { $!ss }

  multi method new (SecretServiceAncestry $secret-service, :$ref = True) {
    return Nil unless $secret-service;

    my $o = self.bless( :$secret-service );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    self.new( :sync );
  }

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
    Int()                   $flags             =  0,
    GCancellable()          $cancellable       =  GCancellable,
    CArray[Pointer[GError]] $error             =  gerror,
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
  )
    is also<clear-finish>
  {
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
  )
    is also<clear-sync>
  {
    so secret_service_clear_sync(
      $!ss,
      $schema,
      $attributes,
      $cancellable,
      $error
    );
  }

  proto method create_collection_dbus_path (|)
    is also<create-collection-dbus-path>
  { * }

  multi method create_collection_dbus_path (
                   %properties,
                   &callback,
    gpointer       $user_data,
    Str()          :$alias       = Str,
    Int()          :$flags       = 0,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      GLib::HashTable::String.new(%properties, :variant);
      $alias,
      $flags,
      $cancellable,
      &callback,
      $user_data
    )
  }
  multi method create_collection_dbus_path (
    GHashTable()   $properties,
                   &callback,
    gpointer       $user_data,
    Str()          :$alias       = Str,
    Int()          :$flags       = 0,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $properties,
      $alias,
      $flags,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method create_collection_dbus_path (
    GHashTable() $properties,
    Str()        $alias,
    Int()        $flags,
    GCancellable $cancellable,
                 &callback,
    gpointer     $user_data
  ) {
    my SecretCollectionCreateFlags $f = $flags;

    secret_service_create_collection_dbus_path(
      $!ss,
      $properties,
      $alias,
      $f,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method create_collection_dbus_path_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error
  )
    is also<create-collection-dbus-path-finish>
  {
    clear_error;
    my $s = secret_service_create_collection_dbus_path_finish($!ss, $result, $error);
    set_error($error);

    $s;
  }

  proto method create_collection_dbus_path_sync (|)
    is also<create-collection-dbus-path-sync>
  { * }

  multi method create_collection_dbus_path_sync (
                            %properties,
    Str()                   $alias       = Str,
    Int()                   $flags       = 0,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    samewith(
      GLib::HashTable::String.new(%properties, :variant),
      $alias,
      $flags,
      $cancellable,
      $error
    );
  }
  multi method create_collection_dbus_path_sync (
    GHashTable()            $properties,
    Str()                   $alias       = Str,
    Int()                   $flags       = 0,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    my SecretCollectionCreateFlags $f = $flags;

    secret_service_create_collection_dbus_path_sync(
      $!ss,
      $properties,
      $alias,
      $flags,
      $cancellable,
      $error
    );
  }

  proto method create_item_dbus_path (|)
    is also<create-item-dbus-path>
  { * }

  # cw: Note that the values in a GHashTable MUST be GVariant!
  multi method create_item_dbus_path (
    Str()           $collection_path,
                    %properties,
    SecretValue()   $value,
                    &callback,
    gpointer        $user_data        = gpointer,
    Int()           :$flags           = 0,
    GCancellable()  :$cancellable     = GCancellable
  ) {
    samewith(
      $collection_path,
      GLib::HashTable::String.new(%properties, :variant),
      $value,
      $flags,
      $cancellable,
      &callback,
      $user_data
    )
  }
  multi method create_item_dbus_path (
    Str()           $collection_path,
    GHashTable()    $properties,
    SecretValue()   $value,
                    &callback,
    gpointer        $user_data        = gpointer,
    Int()           :$flags           = 0,
    GCancellable()  :$cancellable     = GCancellable
  ) {
    samewith(
      $collection_path,
      $properties,
      $value,
      $flags,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method create_item_dbus_path (
    Str()           $collection_path,
    GHashTable()    $properties,
    SecretValue()   $value,
    Int()           $flags,
    GCancellable()  $cancellable,
                    &callback,
    gpointer        $user_data
  ) {
    my SecretCollectionCreateFlags $f = $flags;

    secret_service_create_item_dbus_path(
      $!ss,
      $collection_path,
      $properties,
      $value,
      $f,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method create_item_dbus_path_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error
  )
    is also<create-item-dbus-path-finish>
  {
    clear_error;
    my $s = secret_service_create_item_dbus_path_finish($!ss, $result, $error);
    set_error($error);

    $s;
  }

  proto method create_item_dbus_path_sync (|)
    is also<create-item-dbus-path-sync>
  { * }

  multi method create_item_dbus_path_sync (
    Str()                   $collection_path,
                            %properties,
    SecretValue()           $value,
    SecretItemCreateFlags() $flags       = 0,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    samewith(
      $collection_path,
      GLib::HashTable::String.new(%properties, :variant),
      $value,
      $flags,
      $cancellable,
      $error
    );
  }
  multi method create_item_dbus_path_sync (
    Str()                   $collection_path,
    GHashTable()            $properties,
    SecretValue()           $value,
    SecretItemCreateFlags() $flags       = 0,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    my SecretItemCreateFlags $f = $flags;

    clear_error;
    my $s = secret_service_create_item_dbus_path_sync(
      $!ss,
      $collection_path,
      $properties,
      $value,
      $flags,
      $cancellable,
      $error
    );
    set_error($error);

    $s;
  }

  method decode_dbus_secret (GVariant() $value, :$raw = False) is also<decode-dbus-secret> {
    propReturnObject(
      secret_service_decode_dbus_secret($!ss, $value),
      $raw,
      GVariant,
      GLib::Variant
    );
  }

  proto method delete_item_dbus_path (|)
    is also<delete-item-dbus-path>
  { * }

  multi method delete_item_dbus_path (
    Str()           $item_path,
                    &callback,
    gpointer        $user_data    = gpointer,
    GCancellable()  $cancellable  = GCancellable
  ) {
    samewith($item_path, $cancellable, &callback, $user_data);
  }
  multi method delete_item_dbus_path (
    Str()           $item_path,
    GCancellable()  $cancellable,
                    &callback,
    gpointer        $user_data    = gpointer
  ) {
    secret_service_delete_item_dbus_path(
      $!ss,
      $item_path,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method delete_item_dbus_path_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<delete-item-dbus-path-finish>
  {
    clear_error;
    my $rv = so secret_service_delete_item_dbus_path_finish(
      $!ss,
      $result,
      $error
    );
    set_error($error);

    $rv;
  }

  method delete_item_dbus_path_sync (
    Str()                   $item_path,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  )
    is also<delete-item-dbus-path-sync>
  {
    clear_error;
    my $rv = so secret_service_delete_item_dbus_path_sync(
      $!ss,
      $item_path,
      $cancellable,
      $error
    );
    set_error($error);

    $rv;
  }

  method disconnect {
    secret_service_disconnect();
  }

  method encode_dbus_secret (SecretValue() $value, :$raw = False)
    is also<encode-dbus-secret>
  {
    propReturnObject(
      secret_service_encode_dbus_secret($!ss, $value),
      $raw,
      GVariant,
      GLib::Variant
    )
  }

  proto method get_secret_for_dbus_path (|)
    is also<get-secret-for-dbus-path>
  { * }

  multi method get_secret_for_dbus_path (
    Str()           $item_path,
                    &callback,
    gpointer        $user_data    = gpointer,
    GCancellable()  :$cancellable = GCancellable
  ) {
    samewith($item_path, $cancellable, &callback, $user_data);
  }
  multi method get_secret_for_dbus_path (
    Str()           $item_path,
    GCancellable()  $cancellable,
                    &callback,
    gpointer        $user_data
  ) {
    secret_service_get_secret_for_dbus_path(
      $!ss,
      $item_path,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method get_secret_for_dbus_path_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror,
                            :$raw    = False
  ) is also<get-secret-for-dbus-path-finish> {
    clear_error;
    my $v = secret_service_get_secret_for_dbus_path_finish(
      $!ss,
      $result,
      $error
    );
    set_error($error);

    propReturnObject($v, $raw, GVariant, GLib::Variant);
  }

  method get_secret_for_dbus_path_sync (
    Str()                   $item_path,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror,
                            :$raw        = False
  )
    is also<get-secret-for-dbus-path-sync>
  {
    clear_error;
    my $v = secret_service_get_secret_for_dbus_path_sync(
      $!ss,
      $item_path,
      $cancellable,
      $error
    );
    set_error($error);

    propReturnObject($v, $raw, GVariant, GLib::Variant);
  }

  proto method get_secrets_for_dbus_paths (|)
    is also<get-secrets-for-dbus-paths>
  { * }

  multi method get_secrets_for_dbus_paths (
                 @item_paths,
                 &callback,
    gpointer     $user_data    = gpointer,
    GCancellable :$cancellable = GCancellable
  ) {
    samewith(
      ArrayToCArray(Str, @item_paths),
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method get_secrets_for_dbus_paths (
    CArray[Str]  $item_paths,
    GCancellable $cancellable,
                 &callback,
    gpointer     $user_data    = gpointer
  ) {
    secret_service_get_secrets_for_dbus_paths(
      $!ss,
      $item_paths,
      $cancellable,
      &callback,
      $user_data
    );
  }

  multi method get_secrets_for_dbus_paths_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror,
                            :$raw    = False
  )
    is also<get-secrets-for-dbus-paths-finish>
  {
    clear_error;
    my $h = secret_service_get_secrets_for_dbus_paths_finish(
      $!ss,
      $result,
      $error
    );
    set_error($error);

    propReturnObject($h, $raw, GHashTable, GLib::HashTable);
  }

  proto method get_secrets_for_dbus_paths_sync (|)
    is also<get-secrets-for-dbus-paths-sync>
  { * }

  multi method get_secrets_for_dbus_paths_sync (
                            @item_paths,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    samewith(
      ArrayToCArray(Str, @item_paths),
      $cancellable,
      $error
    );
  }
  multi method get_secrets_for_dbus_paths_sync (
    CArray[Str]             $item_paths,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror,
                            :$raw        = False
  ) {
    clear_error;
    my $h = secret_service_get_secrets_for_dbus_paths_sync(
      $!ss,
      $item_paths,
      $cancellable,
      $error
    );
    set_error($error);

    propReturnObject($h, $raw, GHashTable, GLib::HashTable);
  }

  method get_session_dbus_path is also<get-session-dbus-path> {
    secret_service_get_session_dbus_path($!ss);
  }

  proto method ensure_session (|)
    is also<ensure-session>
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
  )
    is also<ensure-session-finish>
  {
    clear_error;
    my $rv = so secret_service_ensure_session_finish($!ss, $result, $error);
    set_error($error);
    $rv;
  }

  method ensure_session_sync (
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<ensure-session-sync>
  {
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

  method get_collection_gtype is also<get-collection-gtype> {
    secret_service_get_collection_gtype($!ss);
  }

  method get_collections ( :$raw = False, :$glist = False ) is also<get-collections> {
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
  )
    is also<get-finish>
  {
    clear_error;
    my $secret-service = secret_service_get_finish($result, $error);
    set_error($error);
    $secret-service ?? self.bless( :$secret-service ) !! Nil;
  }

  method get_flags is also<get-flags> {
    secret_service_get_flags($!ss);
  }

  method get_item_gtype is also<get-item-gtype> {
    secret_service_get_item_gtype($!ss);
  }

  method get_session_algorithms is also<get-session-algorithms> {
    secret_service_get_session_algorithms($!ss);
  }

  method get_sync (
    Int()                   $flags        = 0,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror
  )
    is also<get-sync>
  {
    my SecretServiceFlags $f = $flags;

    my $secret-service = secret_service_get_sync($f, $cancellable, $error);

    $secret-service ?? self.bless( :$secret-service ) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &secret_service_get_type, $n, $t );
  }

  proto method lock_dbus_paths (|)
    is also<lock-dbus-paths>
  { * }

  multi method lock_dbus_paths (
                 @paths,
                 &callback,
    gpointer     $user_data        = gpointer,
    GCancellable :$cancellable     = GCancellable
  ) {
    samewith( ArrayToCArray(Str, @paths), $cancellable, &callback, $user_data );
  }
  multi method lock_dbus_paths (
    CArray[Str]    $paths,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    secret_service_lock_dbus_paths(
      $!ss,
      $paths,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method lock_dbus_paths_finish (|)
    is also<lock-dbus-paths-finish>
  { * }

  multi method lock_dbus_paths_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    (my $l = CArray[CArray[Str]])[0] = CArray[Str];

    samewith($result, $l, $error);
  }
  multi method lock_dbus_paths_finish (
    GAsyncResult()          $result,
    CArray[Str]             $locked,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $nl = secret_service_lock_dbus_paths_finish($!ss, $result, $locked, $error);
    set_error($error);

    $nl;
  }


  proto method lock_dbus_paths_sync (|)
    is also<lock-dbus-paths-sync>
  { * }

  multi method lock_dbus_paths_sync (
                            @paths,
    CArray[Pointer[GError]] $error         = gerror,
    GCancellable()          :$cancellable  = GCancellable,
  ) {
    (my $l = CArray[CArray[Str]].new)[0] = CArray[Str];

    samewith(
      ArrayToCArray(Str, @paths),
      $cancellable,
      $l,
      $error,
      :all
    );
  }
  multi method lock_dbus_paths_sync (
    CArray[Str]             $paths,
    GCancellable()          $cancellable,
    CArray[CArray[Str]]     $locked,
    CArray[Pointer[GError]] $error         = gerror,
                            :$all          = False
  ) {
    clear_error;
    my $nl = secret_service_lock_dbus_paths_sync(
      $!ss,
      $paths,
      $cancellable,
      $locked,
      $error
    );
    set_error($error);

    $all.not ?? $nl !! CStringArrayToArray( $locked[0] );
  }

  method prompt_at_dbus_path (
    Str()           $prompt_path,
    GVariantType()  $return_type,
    GCancellable()  $cancellable,
                    &callback,
    gpointer        $user_data    = gpointer
  )
    is also<prompt-at-dbus-path>
  {
    secret_service_prompt_at_dbus_path(
      $prompt_path,
      $return_type,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method prompt_at_dbus_path_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<prompt-at-dbus-path-finish>
  {
    clear_error;
    my $s = secret_service_prompt_at_dbus_path_finish($result, $error);
    set_error($error);

    $s;
  }

  method prompt_at_dbus_path_sync (
    Str()                     $prompt_path,
    GCancellable()            $cancellable,
    GVariantType()            $return_type,
    CArray[Pointer[GError]]   $error        = gerror
  )
    is also<prompt-at-dbus-path-sync>
  {
    clear_error;
    my $s = secret_service_prompt_at_dbus_path_sync(
      $!ss,
      $prompt_path,
      $cancellable,
      $return_type,
      $error
    );
    set_error($error);

    $s;
  }

  proto method read_alias_dbus_path (|)
    is also<read-alias-dbus-path>
  { * }

  multi method read_alias_dbus_path (
    Str()            $alias,
                     &callback,
    gpointer         $user_data   = gpointer,
    GCancellable()  :$cancellable = GCancellable
  ) {
    samewith($alias, $cancellable, &callback, $user_data);
  }
  multi method read_alias_dbus_path (
    Str()           $alias,
    GCancellable()  $cancellable,
                    &callback,
    gpointer        $user_data    = gpointer
  ) {
    secret_service_read_alias_dbus_path(
      $!ss,
      $alias,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method read_alias_dbus_path_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<read-alias-dbus-path-finish>
  {
    clear_error;
    my $s = secret_service_read_alias_dbus_path_finish($!ss, $result, $error);
    set_error($error);

    $s;
  }

  method read_alias_dbus_path_sync (
    Str()                   $alias,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  )
    is also<read-alias-dbus-path-sync>
  {
    clear_error;
    my $s = secret_service_read_alias_dbus_path_sync(
      $!ss,
      $alias,
      $cancellable,
      $error
    );
    set_error($error);

    $s;
  }

  proto method search_for_dbus_paths (|)
    is also<search-for-dbus-paths>
  { * }

  multi method search_for_dbus_paths (
    GHashTable()    $attributes,
                    &callback,
    gpointer        $user_data,
    GCancellable()  :$cancellable = GCancellable,
    SecretSchema()  :$schema      = SecretSchema
  ) {
    samewith(
      $schema,
      $attributes,
      $cancellable,
      &callback,
      $user_data
    )
  }
  multi method search_for_dbus_paths (
    SecretSchema()  $schema,
    GHashTable()    $attributes,
    GCancellable()  $cancellable,
                    &callback,
    gpointer        $user_data
  ) {
    secret_service_search_for_dbus_paths(
      $!ss,
      $schema,
      $attributes,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method search_for_dbus_paths_finish (|)
    is also<search-for-dbus-paths-finish>
  { * }

  multi method search_for_dbus_paths_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error     = gerror
  ) {
    my ($u, $l) = CArray[Str].new xx 2;
    ($u, $l)».[0] = Str;

    my $rv = samewith($result, $u, $l, $error, :all);

    $rv
      ?? ( CArrayToArray( $u[0] ), CArrayToArray( $l[0] ) )
      !! Nil;
  }
  multi method search_for_dbus_paths_finish (
    GAsyncResult()          $result,
    CArray[Str]             $unlocked,
    CArray[Str]             $locked,
    CArray[Pointer[GError]] $error     = gerror,
                            :$all      = False
  ) {
    clear_error;
    my $rv = so secret_service_search_for_dbus_paths_finish(
      $result,
      $unlocked,
      $locked,
      $error
    );
    set_error($error);

    $rv;
  }

  proto method search_for_dbus_paths_sync (|)
    is also<search-for-dbus-paths-sync>
  { * }

  multi method search_for_dbus_paths_sync (
    GHashTable()            $attributes,
    CArray[Pointer[GError]] $error        = gerror,
    SecretSchema()          $schema       = SecretSchema,
    GCancellable()          $cancellable  = GCancellable
  ) {
    my ($u, $l) = CArray[Str].new xx 2;
    ($u, $l)».[0] = Str;

    my $rv = samewith($attributes, $cancellable, $u, $l, $error, :all);
    $rv
      ?? ( CStringArrayToArray( $u[0] ), CStringArrayToArray( $l[0] ) )
      !! Nil;
  }
  multi method search_for_dbus_paths_sync (
    SecretSchema()          $schema,
    GHashTable()            $attributes,
    GCancellable()          $cancellable,
    CArray[Str]             $unlocked,
    CArray[Str]             $locked,
    CArray[Pointer[GError]] $error
  ) {
    so secret_service_search_for_dbus_paths_sync(
      $schema,
      $attributes,
      $cancellable,
      $unlocked,
      $locked,
      $error
    );
  }

  proto method load_collections (|)
    is also<load-collections>
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
  )
    is also<load-collections-finish>
  {
    clear_error;
    my $rv = so secret_service_load_collections_finish($!ss, $result, $error);
    set_error($error);
    $rv;
  }

  method load_collections_sync (
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<load-collections-sync>
  {
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
  )
    is also<lock-finish>
  {
    secret_service_lock_finish($!ss, $result, $locked, $error);
  }

  proto method lock_sync (|)
    is also<lock-sync>
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
  )
    is also<lookup-finish>
  {
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
  )
    is also<lookup-sync>
  {
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
  )
    is also<open-finish>
  {
    clear_error;

    my $secret-service = secret_service_open_finish($result, $error);

    $secret-service ?? self.bless( :$secret-service ) !! Nil;
  }

  method open_sync (
    Str()                   $service_bus_name,
    Int()                   $flags,
    GCancellable()          $cancellable       = GCancellable,
    CArray[Pointer[GError]] $error             = gerror
  )
    is also<open-sync>
  {
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
  )
    is also<prompt-finish>
  {
    returnObject(
      secret_service_prompt_finish($!ss, $result, $error),
      $raw,
      GVariant,
      GLib::Variant
    );
  }

  proto method prompt_sync (|)
    is also<prompt-sync>
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

  )
    is also<search-finish>
  {
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
  )
    is also<search-sync>
  {
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
    is also<set-alias>
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
  )
    is also<set-alias-finish>
  {
    secret_service_set_alias_finish($!ss, $result, $error);
  }

  method set_alias_sync (
    Str()                   $alias,
    SecretCollection()      $collection,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) is also<set-alias-sync> {
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

  proto method set_alias_to_dbus_path (|)
    is also<set-alias-to-dbus-path>
  { * }

  multi method set_alias_to_dbus_path (
    Str()           $alias,
                    &callback,
    Str()           :$collection_path = Str,
    GCancellable()  :$cancellable     = GCancellable,
    gpointer        :$user_data       = gpointer
  ) {
    samewith(
      $!ss,
      $alias,
      $collection_path,
      $cancellable,
      &callback,
      $user_data
    )
  }
  multi method set_alias_to_dbus_path (
    Str()           $alias,
    Str()           $collection_path,
    GCancellable()  $cancellable,
                    &callback,
    gpointer        $user_data    = gpointer
  ) {
    so secret_service_set_alias_to_dbus_path(
      $!ss,
      $alias,
      $collection_path,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method set_alias_to_dbus_path_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<set-alias-to-dbus-path-finish>
  {
    clear_error;
    my $rv = so secret_service_set_alias_to_dbus_path_finish(
      $!ss,
      $result,
      $error
    );
    set_error($error);

    $rv;
  }

  method set_alias_to_dbus_path_sync (
    Str()                   $alias,
    Str()                   $collection_path = Str,
    GCancellable()          $cancellable     = GCancellable,
    CArray[Pointer[GError]] $error           = gerror
  )
    is also<set-alias-to-dbus-path-sync>
  {
    clear_error;
    my $rv = so secret_service_set_alias_to_dbus_path_sync(
      $!ss,
      $alias,
      $collection_path,
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
  )
    is also<store-finish>
  {
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
  ) is also<store-sync> {
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

  proto method unlock_finish (|)
    is also<unlock-finish>
  { * }

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
    is also<unlock-sync>
  { * }

  multi method unlock_sync (
    GList()                 $objects,
    CArray[Pointer[GError]] $error        = gerror,
    GCancellable()          :$cancellable = GCancellable,
                            :$raw         =  False,
                            :$glist       =  False,
                            :$seq         =  True
  ) {
    samewith($objects, $cancellable, $, $error, :$raw, :$glist, :$seq);
  }
  multi method unlock_sync (
    GList()                 $objects,
    GCancellable()          $cancellable,
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

  proto method unlock_dbus_paths (|)
    is also<unlock-dbus-paths>
  { * }

  multi method unlock_dbus_paths (
                    @paths,
                    &callback,
    GCancellable()  $cancellable,
    gpointer        $user_data    = gpointer
  ) {
    samewith( ArrayToCArray(Str, @paths), $cancellable, &callback, $user_data);
  }
  multi method unlock_dbus_paths (
    CArray[Str]     $paths,
    GCancellable()  $cancellable,
                    &callback,
    gpointer        $user_data    = gpointer
  ) {
    secret_service_unlock_dbus_paths(
      $!ss,
      $paths,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method unlock_dbus_paths_finish (|)
    is also<unlock-dbus-paths-finish>
  { * }

  multi method unlock_dbus_paths_finish (
    GAsyncResult()         $result,
    Array[Pointer[GError]] $error    =  gerror
  ) {
    samewith($result, $, $error);
  }
  multi method unlock_dbus_paths_finish (
    GAsyncResult()         $result,
                           $unlocked is rw,
    Array[Pointer[GError]] $error    =  gerror
  ) {
    (my $u = CArray[Str].new)[0] = Str;

    my $nu = samewith($result, $u, $error);
    $unlocked = CStringArrayToArray($u);
    $nu;
  }
  multi method unlock_dbus_paths_finish (
    GAsyncResult()          $result,
    CArray[Str]             $unlocked,
    CArray[Pointer[GError]] $error     = gerror
  ) {
    clear_error;
    my $nu = secret_service_unlock_dbus_paths_finish(
      $!ss,
      $result,
      $unlocked,
      $error
    );
    set_error($error);

    $nu;
  }

  proto method unlock_dbus_paths_sync (|)
    is also<unlock-dbus-paths-sync>
  { * }

  multi method unlock_dbus_paths_sync (
                            @paths,
    CArray[Pointer[GError]] $error        = gerror,
    GCancellable()          :$cancellable = GCancellable
  ) {
    samewith(
      ArrayToCArray(Str, @paths),
      $cancellable,
      $error
    );
  }
  multi method unlock_dbus_paths_sync (
    CArray[Str]             $paths,
    CArray[Pointer[GError]] $error        = gerror,
    GCancellable()          :$cancellable = GCancellable
  ) {
    (my $u  = CArray[CArray[Str]])[0] = CArray[Str];
    my $nu = samewith($paths, $cancellable, $u, $error);

    # cw: ???
    CArrayToArray($u).map({ CStringArrayToArray($_) });
  }
  multi method unlock_dbus_paths_sync (
    CArray[Str]             $paths,
    GCancellable()          $cancellable,
    CArray[CArray[Str]]     $unlocked,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $nu = secret_service_unlock_dbus_paths_sync(
      $!ss,
      $paths,
      $cancellable,
      $unlocked,
      $error
    );
    set_error($error);

    $nu;
  }

}
