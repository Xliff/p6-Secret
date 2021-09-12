use v6.c;

use NativeCall;

use Secret::Raw::Types;
use Secret::Raw::Collection;

use GLib::GList;
use GIO::DBus::Proxy;

class Secret::Collection is GIO::DBus::Proxy {
  has SecretCollection $!sc;

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
  ) {
    my $secret-collection = secret_collection_create_finish($result, $error);

    $secret-collection ?? self.bless( :$secret-collection ) !! Nil;
  }

  method create_sync (
    SecretService()         $service,
    Str()                   $label,
    Str()                   $alias,
    Int()                   $flags,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    my SecretCollectionCreateFlags $f = $flags;

    clear_error;
    my $secret-collection = secret_collection_create_sync(
      $service,
      $label,
      $alias,
      $f,
      $cancellable,
      $error
    );
    set_error($error);

    $secret-collection ?? self.bless( :$secret-collection ) !! Nil;
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
  ) {
    clear_error;
    my $rv = so secret_collection_delete_finish($!sc, $result, $error);
    set_error($error);
    $rv;
  }

  method delete_sync (
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $rv = so secret_collection_delete_sync($!sc, $cancellable, $error);
    set_error($error);
    $rv;
  }

  proto method for_alias (|)
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
  ) {
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
  ) {
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

  method get_created (:$raw = False) {
    my $dt = secret_collection_get_created($!sc);
    return $dt if $raw;
    DateTime.new($dt);
  }

  method get_flags {
    secret_collection_get_flags($!sc);
  }

  method get_items (:$raw = False, :$glist = False) {
    returnGList(
      secret_collection_get_items($!sc),
      $raw,
      $glist,
      SecretItem,
      Secret::Item
    );
  }

  method get_label {
    secret_collection_get_label($!sc);
  }

  method get_locked {
    so secret_collection_get_locked($!sc);
  }

  method get_modified (:$raw = False) {
    my $dt = secret_collection_get_modified($!sc);
    return $dt if $raw;
    DateTime.new($dt);
  }

  method get_service (:$raw) {
    propReturnObject(
      secret_collection_get_service($!sc),
      $raw,
      SecretService,
      Secret::Service
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &secret_collection_get_type, $n, $t );
  }

  method load_items (
    GCancellable $cancellable, &callback,
    gpointer $user_data
  ) {
    secret_collection_load_items($!sc, $cancellable, &callback, $user_data);
  }

  method load_items_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error
  ) {
    secret_collection_load_items_finish($!sc, $result, $error);
  }

  method load_items_sync (
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error
  ) {
    secret_collection_load_items_sync($!sc, $cancellable, $error);
  }

  method refresh {
    secret_collection_refresh($!sc);
  }

  method search (
    SecretSchema $schema,
    GHashTable $attributes,
    Int() $flags,
    GCancellable $cancellable,
    &callback,
    gpointer $user_data
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
  ) {
    clear_error;
    my $sil = secret_collection_search_finish($!sc, $result, $error);
    set_error($error);
    returnGList($sil, $raw, $glist, SecretItem, Secret::Item);
  }

  method search_sync (
    SecretSchema()          $schema,
    GHashTable()            $attributes,
    Int()                   $flags,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror,
                            :$raw         = False,
                            :$glist       = False
  ) {
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
    returnGList($sil, $raw, $glist, SecretItem, Secret::Item);
  }

  proto method set_label (|)
  { * }

  multi method set_label (
    Str()          $label,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable
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
    CArray[Pointer[GError]] $error
  ) {
    clear_error;
    secret_collection_set_label_finish($!sc, $result, $error);
    set_error($error);
  }

}
