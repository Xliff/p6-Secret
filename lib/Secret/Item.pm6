use v6.c;

use NativeCall;

use Method::Also;

use Secret::Raw::Types;
use Secret::Raw::Item;

use GLib::Value;
use GIO::DBus::Proxy;

our subset SecretItemAncestry is export of Mu
  where SecretItem | GDBusProxyAncestry;

class Secret::Item is GIO::DBus::Proxy {
  has SecretItem $!si is implementor;

  submethod BUILD (
    :initable-object( :$secret-item ),
    :$init,
    :$cancellable
  ) {
    self.setSecretItem($secret-item, :$init, :$cancellable) if $secret-item;
  }

  method setSecretItem (
    SecretItemAncestry $_,
                       :$init,
                       :$cancellable
  ) {
    my $to-parent;

    $!si = do {
      when SecretItem {
        $to-parent = cast(GDBusProxy, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(SecretItem, $_);
      }
    }

    self.setGDBusProxy($to-parent, :$init, :$cancellable);
  }

  method GIO::Raw::Definitions::SecretItem
    is also<SecretItem>
  { $!si }

  multi method new (SecretItemAncestry $secret-item, :$ref = True) {
    return Nil unless $secret-item;

    my $o = self.bless( :$secret-item );
    $o.ref if $ref;
    $o;
  }

  # Type: SecretItemFlags
  method flags is rw  {
    my $gv = GLib::Value.new( GLib::Value.gtypeFromType(SecretItemFlags) );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('flags', $gv)
        );

        $gv.valueFromType(SecretItemFlags);
      },
      STORE => -> $,  $val is copy {
        warn 'flags is a construct-only attribute'
      }
    );
  }

  # Type: gboolean
  method locked is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('locked', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'locked does not allow writing'
      }
    );
  }

  # Type: SecretService
  method service (:$raw = False) is rw  {
    my $gv = GLib::Value.new( Secret::Service.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('service', $gv)
        );

        propReturnObject(
          $gv.object,
          $raw,
          SecretService,
          Secret::Service
        );
      },
      STORE => -> $,  $val is copy {
        warn 'service is a construct-only attribute'
      }
    );
  }

  proto method create (|)
  { * }

  multi method create (
    SecretCollection() $collection,
    SecretSchema()     $schema,
    GHashTable()       $attributes,
    Str()              $label,
    SecretValue()      $value,
                       &callback,
    gpointer           $user_data    = gpointer,
    Int()              :$flags       = 0,
    GCancellable()     :$cancellable = GCancellable
  ) {
    samewith(
      $collection,
      $schema,
      $attributes,
      $label,
      $value,
      $flags,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method create (
    Secret::Item:U:

    SecretCollection() $collection,
    SecretSchema()     $schema,
    GHashTable()       $attributes,
    Str()              $label,
    SecretValue()      $value,
    Int()              $flags,
    GCancellable()     $cancellable,
                       &callback,
    gpointer           $user_data    = gpointer
  ) {
    my SecretItemCreateFlags $f = $flags;

    secret_item_create(
      $collection,
      $schema,
      $attributes,
      $label,
      $value,
      $f,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method create_finish (
    Secret::Item:U:

    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<create-finish>
  {
    clear_error;
    my $secret-item = secret_item_create_finish($result, $error);
    set_error($error);

    $secret-item ?? self.bless( :$secret-item ) !! Nil;
  }

  method create_sync (
    SecretCollection()      $collection,
    SecretSchema()          $schema,
    GHashTable()            $attributes,
    Str()                   $label,
    SecretValue()           $value,
    Int()                   $flags,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror;
  )
    is also<create-sync>
  {
    my SecretItemCreateFlags $f = $flags;

    clear_error;
    my $secret-item = secret_item_create_sync(
      $collection,
      $schema,
      $attributes,
      $label,
      $value,
      $f,
      $cancellable,
      $error
    );
    set_error($error);

    $secret-item ?? self.bless( :$secret-item ) !! Nil;
  }

  proto method delete (|)
  { * }

  multi method delete (
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method delete (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    secret_item_delete($!si, $cancellable, &callback, $user_data);
  }

  method delete_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<delete-finish>
  {
    clear_error;
    my $rv = so secret_item_delete_finish($!si, $result, $error);
    set_error($error);
    $rv;
  }

  method delete_sync (
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<delete-sync>
  {
    clear_error;
    my $rv = so secret_item_delete_sync($!si, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method get_attributes (:$raw = False) is also<get-attributes> {
    propReturnObject(
      secret_item_get_attributes($!si),
      $raw,
      GHashTable,
      GLib::HashTable
    );
  }

  method get_created (:$raw = False) is also<get-created> {
    my $c = secret_item_get_created($!si);
    return $c if $raw;
    DateTime.new($c);
  }

  method get_flags is also<get-flags> {
    secret_item_get_flags($!si);
  }

  method get_label is also<get-label> {
    secret_item_get_label($!si);
  }

  method get_locked is also<get-locked> {
    so secret_item_get_locked($!si);
  }

  method get_modified (:$raw = False) is also<get-modified> {
    my $m = secret_item_get_modified($!si);
    return $m if $raw;
    DateTime.new($m);
  }

  method get_schema_name is also<get-schema-name> {
    secret_item_get_schema_name($!si);
  }

  method get_secret (:$raw = False) is also<get-secret> {
    propReturnObject(
      secret_item_get_secret($!si),
      $raw,
      SecretValue,
      Secret::Value
    );
  }

  method get_service (:$raw = False) is also<get-service> {
    propReturnObject(
      secret_item_get_service($!si),
      $raw,
      SecretService,
      Secret::Service
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &secret_item_get_type, $n, $t );
  }

  proto method load_secret (|)
      is also<load-secret>
  { * }

  multi method load_secret (
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method load_secret (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    secret_item_load_secret($!si, $cancellable, &callback, $user_data);
  }

  method load_secret_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<load-secret-finish>
  {
    clear_error;
    my $rv = so secret_item_load_secret_finish($!si, $result, $error);
    set_error($error);
    $rv;
  }

  method load_secret_sync (
    GCancellable            $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror
  )
    is also<load-secret-sync>
  {
    clear_error;
    my $rv = so secret_item_load_secret_sync($!si, $cancellable, $error);
    set_error($error);
    $rv;
  }

  proto method load_secrets (|)
      is also<load-secrets>
  { * }

  multi method load_secrets (
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() $cancellable  = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method load_secrets (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    secret_item_load_secrets($!si, $cancellable, &callback, $user_data);
  }

  method load_secrets_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-secrets-finish>
  {
    clear_error;
    my $rv = so secret_item_load_secrets_finish($result, $error);
    set_error($error);
    $rv;
  }

  method load_secrets_sync (
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<load-secrets-sync>
  {
    clear_error;
    my $rv = so secret_item_load_secrets_sync($!si, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method refresh {
    secret_item_refresh($!si);
  }

  proto method set_attributes (|)
      is also<set-attributes>
  { * }

  multi method set_attributes (
    SecretSchema() $schema,
    GHashTable()   $attributes,
                   &callback,
    gpointer       $user_data     = gpointer,
    GCancellable() :$cancellable  = GCancellable
  ) {
    samewith($schema, $attributes, $cancellable, &callback, $user_data);
  }
  multi method set_attributes (
    SecretSchema() $schema,
    GHashTable()   $attributes,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    secret_item_set_attributes(
      $!si,
      $schema,
      $attributes,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method set_attributes_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<set-attributes-finish>
  {
    clear_error;
    my $rv = so secret_item_set_attributes_finish($!si, $result, $error);
    set_error($error);
    $rv;
  }

  method set_attributes_sync (
    SecretSchema()          $schema,
    GHashTable()            $attributes,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror
  )
    is also<set-attributes-sync>
  {
    clear_error;
    my $rv = so secret_item_set_attributes_sync(
      $!si,
      $schema,
      $attributes,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method set_label (|)
      is also<set-label>
  { * }

  multi method set_label (
    Str()          $label,
                   &callback,
    gpointer       $user_data   = gpointer,
    GCancellable() $cancellable = GCancellable
  ) {
    samewith($label, $cancellable, &callback, $user_data);
  }
  multi method set_label (
    Str()          $label,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    secret_item_set_label($!si, $label, $cancellable, &callback, $user_data);
  }

  method set_label_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<set-label-finish>
  {
    clear_error;
    my $rv = so secret_item_set_label_finish($!si, $result, $error);
    set_error($error);
    $rv;
  }

  method set_label_sync (
    Str()                   $label,
    GCancellable            $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<set-label-sync>
  {
    clear_error;
    my $rv = so secret_item_set_label_sync($!si, $label, $cancellable, $error);
    set_error($error);
    $rv;
  }

  proto method set_secret (|)
    is also<set-secret>
  { * }

  multi method set_secret (
    SecretValue()  $value,
                   &callback,
    gpointer       $user_data   = gpointer,
    GCancellable() $cancellable = GCancellable
  ) {
    samewith($value, $cancellable, &callback, $user_data);
  }
  multi method set_secret (
    SecretValue()  $value,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    secret_item_set_secret($!si, $value, $cancellable, &callback, $user_data);
  }

  method set_secret_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-secret-finish>
  {
    clear_error;
    my $rv = so secret_item_set_secret_finish($!si, $result, $error);
    set_error($error);
  }

  method set_secret_sync (
    SecretValue()           $value,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror
  )
    is also<set-secret-sync>
  {
    clear_error;
    my $rv = so secret_item_set_secret_sync($!si, $value, $cancellable, $error);
    set_error($error);
    $rv
  }

}
