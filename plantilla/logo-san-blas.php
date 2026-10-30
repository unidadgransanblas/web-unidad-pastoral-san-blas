<?php
/*
 * Pone el logo de la Unidad Pastoral del Gran San Blas en la portada (página Home), en lugar del de la plantilla,
 * a 510 px como el original. Lo ejecuta el blueprint después de importar; se puede repetir sin duplicar nada.
 * Color: 'verde' o 'azul' (los dos logos de plantilla/logos/).
 */
require_once '/wordpress/wp-load.php';
require_once ABSPATH . 'wp-admin/includes/image.php';

$color = 'verde';
$rel = "san-blas/logo-gran-san-blas-$color.png";
$id = get_posts( array( 'post_type' => 'attachment', 'meta_key' => '_wp_attached_file', 'meta_value' => $rel, 'fields' => 'ids', 'numberposts' => 1 ) )[0] ?? 0;
if ( ! $id ) {
	$file = wp_upload_dir()['basedir'] . '/' . $rel;
	wp_mkdir_p( dirname( $file ) );
	copy( "/plantilla/logos/logo-gran-san-blas-$color.png", $file );
	$id = wp_insert_attachment( array( 'post_title' => 'Logo Unidad Pastoral del Gran San Blas', 'post_mime_type' => 'image/png', 'post_status' => 'inherit' ), $file );
	wp_update_attachment_metadata( $id, wp_generate_attachment_metadata( $id, $file ) );
	update_post_meta( $id, '_wp_attachment_image_alt', 'Unidad Pastoral del Gran San Blas' );
}

$home = get_page_by_path( 'home' );
if ( $home ) {
	$url = wp_get_attachment_url( $id );
	$c = preg_replace( '#[^"\s\]\[]*(?:00white|logo-gran-san-blas-(?:verde|azul))[^"\s\]\[]*\.png#', $url, $home->post_content );
	$c = preg_replace( '#(\[fusion_imageframe[^\]]*image_id=")\d+#', '${1}' . $id, $c );
	$c = preg_replace_callback( '#\[fusion_imageframe[^\]]*logo-gran-san-blas[^\]]*\]|\[fusion_imageframe[^\]]*\](?=[^\[]*logo-gran-san-blas)#', function ( $m ) {
		return str_replace( '[fusion_imageframe ', '[fusion_imageframe max_width="510px" ', preg_replace( '#\smax_width="[^"]*"#', '', $m[0] ) );
	}, $c );
	wp_update_post( array( 'ID' => $home->ID, 'post_content' => $c ) );
}
if ( function_exists( 'fusion_reset_all_caches' ) ) { fusion_reset_all_caches(); }
