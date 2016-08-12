# Custom puppet manifets to configure scaleio backend on overcloud
# If running outside of heat then the cinder volume service must be restarted manually:
# pcs resource restart openstack-cinder-volume 

if hiera('bootstrap_nodeid', undef) =~ /controller/ {

include ::cinder::params
include ::cinder::config


cinder_config {
     'DEFAULT/enabled_backends': value => 'ScaleIO_SP1,ScaleIO_SP2';

     'ScaleIO_SP1/volume_driver': value => 'cinder.volume.drivers.emc.scaleio.ScaleIODriver';
     'ScaleIO_SP1/volume_backend_name': value => 'ScaleIO';
     'ScaleIO_SP1/san_ip': value => hiera('scaleio::params::san_ip');
     'ScaleIO_SP1/san_login': value => hiera('scaleio::params::san_login');
     'ScaleIO_SP1/san_password': value => hiera('scaleio::params::san_password');
     'ScaleIO_SP1/sio_protection_domain_name': value => 'Domain1';
     'ScaleIO_SP1/sio_storage_pool_name': value => 'pool1';
     'ScaleIO_SP1/sio_storage_pools': value => 'Domain1:pool1,Domain1:pool2';
     'ScaleIO_SP1/sio_force_delete': value => 'False';
     'ScaleIO_SP1/sio_round_volume_capacity': value => 'True';

     'ScaleIO_SP2/volume_driver': value => 'cinder.volume.drivers.emc.scaleio.ScaleIODriver';
     'ScaleIO_SP2/volume_backend_name': value => 'ScaleIO';
     'ScaleIO_SP2/san_ip': value => hiera('scaleio::params::san_ip');
     'ScaleIO_SP2/san_login': value => hiera('scaleio::params::san_login');
     'ScaleIO_SP2/san_password': value => hiera('scaleio::params::san_password');
     'ScaleIO_SP2/sio_protection_domain_name': value => 'Domain1';
     'ScaleIO_SP2/sio_storage_pool_name': value => 'pool2';
     'ScaleIO_SP2/sio_storage_pools': value => 'Domain1:pool1,Domain1:pool2';
     'ScaleIO_SP2/sio_force_delete': value => 'False';
     'ScaleIO_SP2/sio_round_volume_capacity': value => 'True';
}

}
