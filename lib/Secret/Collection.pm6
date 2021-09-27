use v6.c;

use Method::Also;

use NativeCall;

use Secret::Raw::Types;
use Secret::Raw::Collection;
use Secret::Raw::Paths;

use GLib::GList;
use GIO::DBus::Proxy;

our subset SecretCollectionAncestry is export of Mu
  where SecretCollection | GDBusProxy;

class Secret::Collection is GIO::DBus::Proxy {
  has SecretCollection $!sc;

  submethod BUILD (
    :initable-object( :$secret-Collection ),
    :$init,
    :$cancellable
  ) {
    self.setSecretCollection(
      $secret-Collection,
      :$init,
      :$cancellable
    ) if $secret-Collection;
  }

  method setSecretCollection (
    SecretCollectionAncestry $_,
                            :$init,
                            :$cancellable
  ) {
    my $to-parent;

    $!sc = do {
      when SecretCollection {
        $to-parent = cast(GDBusProxy, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(SecretCollection, $_);
      }
    }

    self.setGDBusProxy($to-parent, :$init, :$cancellable);
  }

  method Secret::Raw::Structs::SecretCollection
    is also<SecretCollection>
  { $!sc }

  multi method new (SecretCollectionAncestry $secret-Collection, :$ref = True) {
    return Nil unless $secret-Collection;

    my $o = self.bless( :$secret-Collection);
    $o.ref if $ref;
    $o;
  }
  multi method new (
    SecretService() $service,
    Str()           $label,
    Str()           $alias,
    Int()           $flags,
                    &callback,
    gpointer        $user_data    =  gpointer,
    GCancellable()  :$cancellable =  GCancellable,
                    :$create      is required
  ) {
    self.create(
      $service,
      $label,
      $alias,
      $flags,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method new (
    SecretService()         $service,
    Str()                   $label,
    Str()                   $alias,
    Int()                   $flags,
    GCancellable()          $cancellable                =  GCancellable,
    CArray[Pointer[GError]] $error                      =  gerror,
                            :create_sync(:$create-sync) is required
  ) {
    samewith($service, $flags, $cancellable, $error);
  }

  proto method new_for_dbus_path (|)
    is also<new-for-dbus-path>
  { * }

  multi method new_for_dbus_path (
    Str()           $collection_path,
                    &callback,
    gpointer        $user_data        = gpointer,
    SecretService() :$service         = SecretService,
    Int()           :$flags           = 0,
    GCancellable()  :$cancellable     = GCancellable
  ) {
    samewith(
      $service,
      $collection_path,
      $flags,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method new_for_dbus_path (
    SecretService $service,
    Str           $collection_path,
    Int           $flags,
    GCancellable  $cancellable,
                  &callback,
    gpointer      $user_data
  ) {
    my $secret-Collection = secret_collection_new_for_dbus_path(
      $service,
      $collection_path,
      $flags,
      $cancellable,
      &callback,
      $user_data
    );

    $secret-Collection ?? self.bless( :$secret-Collection ) !! Nil;
  }

  method new_for_dbus_path_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror;
  )
    is also<new-for-dbus-path-finish>
  {
    clear_error;
    my $secret-Collection = secret_collection_new_for_dbus_path_finish(
      $result,
      $error
    );
    set_error($error);

    $secret-Collection?? self.bless( :$secret-Collection ) !! Nil;
  }

  proto method new_for_dbus_path_sync (|)
    is also<new-for-dbus-path-sync>
  { * }

  multi method new_for_dbus_path_sync (
    Str()                   $collection_path,
    CArray[Pointer[GError]] $error            = gerror,
    Int()                   :$flags           = 0,
    SecretService()         :$service         = SecretService,
    GCancellable()          :$cancellable     = GCancellable
  ) {
    samewith($service, $collection_path, $flags, $cancellable, $error);
  }
  multi method new_for_dbus_path_sync (
    SecretService()         $service,
    Str()                   $collection_path,
    Int()                   $flags            = 0,
    GCancellable()          $cancellable      = GCancellable,
    CArray[Pointer[GError]] $error            = gerror
  ) {
    my SecretCollectionFlags $f = $flags;

    clear_error;
    my $secret-Collection= secret_collection_new_for_dbus_path_sync(
      $service,
      $collection_path,
      $flags,
      $cancellable,
      $error
    );
    set_error($error);

    $secret-Collection?? self.bless( :$secret-Collection ) !! Nil;
  }

  proto method create (|)
  { * }

  multi method create (
    SecretService() $service,
    Str()           $label,
    Str()           $alias,
    Int()           $flags,
                    &callback,
    gpointer        $user_data    = gpointer,
    GCancellable()  :$cancellable = GCancellable
  ) {
    samewith(
      $service,
      $label,
      $alias,
      $flags,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method create (
    SecretService() $service,
    Str()           $label,
    Str()           $alias,
    Int()           $flags,
    GCancellable()  $cancellable,
                    &callback,
    gpointer        $user_data    = gpointer
  ) {
    my SecretCollectionCreateFlags $f = $flags;

    secret_collection_create(
      $!sc,
      $label,
      $alias,
      $f,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method create_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error  = gerror
  )
    is also<create-finish>
  {
    my $secret-Collection = secret_collection_create_finish($result, $error);

    $secret-Collection ?? self.bless( :$secret-Collection ) !! Nil;
  }

  method create_sync (
    SecretService()         $service,
    Str()                   $label,
    Str()                   $alias,
    Int()                   $flags,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<create-sync>
  {
    my SecretCollectionCreateFlags $f = $flags;

    clear_error;
    my $secret-Collection = secret_collection_create_sync(
      $service,
      $label,
      $alias,
      $f,
      $cancellable,
      $error
    );
    set_error($error);

    $secret-Collection ?? self.bless( :$secret-Collection ) !! Nil;
  }

  proto method delete (|)
  { * }

  multi method delete (
                   &callback,
    gpointer       $user_data   = gpointer,
    GCancellable() $cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method delete (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    secret_collection_delete($!sc, $cancellable, &callback, $user_data);
  }

  method delete_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<delete-finish>
  {
    clear_error;
    my $rv = so secret_collection_delete_finish($!sc, $result, $error);
    set_error($error);
    $rv;
  }

  method delete_sync (
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  )
    is also<delete-sync>
  {
    clear_error;
    my $rv = so secret_collection_delete_sync($!sc, $cancellable, $error);
    set_error($error);

    $rv;
  }

  proto method for_alias (|)
    is also<for-alias>
  { * }

  multi method for_alias (
    Secret::Collection:U:

    SecretService() $service,
    Str()           $alias,
    Int()           $flags,
                    &callback,
    gpointer        $user_data    = gpointer,
    GCancellable()  :$cancellable = GCancellable
  ) {
    samewith($service, $alias, $flags, $cancellable, &callback, $user_data);
  }
  multi method for_alias (
    Secret::Collection:U:

    SecretService() $service,
    Str()           $alias,
    Int()           $flags,
    GCancellable()  $cancellable,
                    &callback,
    gpointer        $user_data    = gpointer
  ) {
    my SecretCollectionCreateFlags $f = $flags;

    secret_collection_for_alias(
      $service,
      $alias,
      $f,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method for_alias_finish (
    Secret::Collection:U:

    GAsyncResult            $result,
    CArray[Pointer[GError]] $error   = gerror,
                            :$raw    = False
  )
    is also<for-alias-finish>
  {
    propReturnObject(
      secret_collection_for_alias_finish($result, $error),
      $raw,
      SecretCollection,
      Secret::Collection
    );
  }

  method for_alias_sync (
    Secret::Collection:U:

    SecretService()         $service,
    Str                     $alias,
    Int()                   $flags,
    GCancellable            $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror,
                            :$raw        = False
  )
    is also<for-alias-sync>
  {
    my SecretCollectionCreateFlags $f = $flags;

    clear_error;
    my $c = secret_collection_for_alias_sync(
      $service,
      $alias,
      $f,
      $cancellable,
      $error
    );
    set_error($error);

    propReturnObject($c, $raw, SecretCollection, Secret::Collection);
  }

  method get_created (:$raw = False) is also<get-created> {
    my $dt = secret_collection_get_created($!sc);
    return $dt if $raw;
    DateTime.new($dt);
  }

  method get_flags is also<get-flags> {
    secret_collection_get_flags($!sc);
  }

  method get_items (:$raw = False, :$glist = False) is also<get-items> {
    returnGList(
      secret_collection_get_items($!sc),
      $raw,
      $glist,
      SecretCollection,
      Secret::Collection
    );
  }

  method get_label is also<get-label> {
    secret_collection_get_label($!sc);
  }

  method get_locked is also<get-locked> {
    so secret_collection_get_locked($!sc);
  }

  method get_modified (:$raw = False) is also<get-modified> {
    my $dt = secret_collection_get_modified($!sc);
    return $dt if $raw;
    DateTime.new($dt);
  }

  method get_service (:$raw) is also<get-service> {
    propReturnObject(
      secret_collection_get_service($!sc),
      $raw,
      SecretService,
      Secret::Service
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &secret_collection_get_type, $n, $t );
  }

  proto method load_items (|)
      is also<load-items>
  { * }

  multi method load_items (
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() $cancellable  = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method load_items (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    secret_collection_load_items($!sc, $cancellable, &callback, $user_data);
  }

  method load_items_finish (
    GAsyncResult            $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<load-items-finish>
  {
    clear_error;
    my $rv = so secret_collection_load_items_finish($!sc, $result, $error);
    set_error($error);

    $rv;
  }

  method load_items_sync (
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<load-items-sync>
  {
    so secret_collection_load_items_sync($!sc, $cancellable, $error);
  }

  method refresh {
    secret_collection_refresh($!sc);
  }

  method search (
    SecretSchema() $schema,
    GHashTable()   $attributes,
    Int()          $flags,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    my SecretSearchFlags $f = $flags;

    secret_collection_search(
      $!sc,
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
    my $sil = secret_collection_search_finish($!sc, $result, $error);
    set_error($error);
    returnGList($sil, $raw, $glist, SecretCollection, Secret::Collection);
  }

  method search_sync (
    SecretSchema()          $schema,
    GHashTable()            $attributes,
    Int()                   $flags,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror,
                            :$raw         = False,
                            :$glist       = False
  )
    is also<search-sync>
  {
    my SecretSearchFlags $f = $flags;

    clear_error;
    my $sil = secret_collection_search_sync(
      $!sc,
      $schema,
      $attributes,
      $f,
      $cancellable,
      $error
    );
    set_error($error);
    returnGList($sil, $raw, $glist, SecretCollection, Secret::Collection);
  }

  proto method search_for_dbus_paths (|)
    is also<search-for-dbus-paths>
  { * }

  multi method search_for_dbus_paths (
    GHashTable()       $attributes,
                       &callback,
    gpointer           $user_data,
    GCancellable()     :$cancellable = GCancellable,
    SecretSchema()     :$schema      = SecretSchema
  ) {
    samewith(
      $schema,
      $attributes,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method search_for_dbus_paths (
    SecretSchema()     $schema,
    GHashTable()       $attributes,
    GCancellable()     $cancellable,
                       &callback,
    gpointer           $user_data
  ) {
    secret_collection_search_for_dbus_paths(
      $!sc,
      $schema,
      $attributes,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method search_for_dbus_paths_finish (
    GAsyncResult            $result,
    CArray[Pointer[GError]] $error   = gerror,
                            :$raw    = False
  )
    is also<search-for-dbus-paths-finish>
  {
    clear_error;
    my $p = so secret_collection_search_for_dbus_paths_finish(
      $!sc,
      $result,
      $error
    );
    set_error($error);

    $raw ?? $p !! CArrayToArray($p);
  }

  proto method search_for_dbus_paths_sync (|)
    is also<search-for-dbus-paths-sync>
  { * }

  multi method search_for_dbus_paths_sync (
    GHashTable              $attributes,
    GCancellable            $cancellable,
    CArray[Pointer[GError]] $error        = gerror,
    SecretSchema()          :$schema      = SecretSchema,
                            :$raw         = False
  ) {
    samewith($schema, $attributes, $cancellable, $error, :$raw);
  }
  multi method search_for_dbus_paths_sync (
    SecretSchema()          $schema,
    GHashTable()            $attributes,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror,
                            :$raw        = False
  ) {
    clear_error;
    my $p = secret_collection_search_for_dbus_paths_sync(
      $!sc,
      $schema,
      $attributes,
      $cancellable,
      $error
    );
    set_error($error);

    $raw ?? $p !! CArrayToArray($p);
  }

  proto method set_label (|)
    is also<set-label>
  { * }

  multi method set_label (
    Str()          $label,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($label, $cancellable, &callback, $user_data);
  }
  multi method set_label (
    Str()          $label,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    secret_collection_set_label(
      $!sc,
      $label,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method set_label_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<set-label-finish>
  {
    clear_error;
    secret_collection_set_label_finish($!sc, $result, $error);
    set_error($error);
  }

}
