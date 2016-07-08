<?php  if (!defined('BASEPATH')) exit('No direct script access allowed');
// ---------------------------------------------------------------------
class Languagecheck extends CI_Controller {

	/*
	 * utilizar este lenguaje como referencia de comparación.
	 * Este debe ser el que se ha completado.
	 */
	private $reference = 'english';

	private $lang_path = 'language';

	// -----------------------------------------------------------------

	/*
	 * controlador constructor
	 */
	function Languagecheck()
	{
		parent::Controller();
	}

	// -----------------------------------------------------------------

	/*
	 * uso de reasignación para capturar todas las llamadas a este controlador
	 */
	function _remap()
	{
		// cargar los helpers necesarios
		$this->load->helper('directory');

		// por simplicidad , no utilizamos vistas
		$this->output('h1', 'Sale - Language file checking and validation');

		// determinar la ruta de archivo de idioma
		if ( ! is_dir($this->lang_path) )
		{
			$this->lang_path = APPPATH . $this->lang_path;

			if ( ! is_dir($this->lang_path) )
			{
				$this->output('h2', 'Defined language path "'.$this->lang_path.'" not found!', TRUE);
				exit;
			}
		}

		// buscar el mapa del directorio de idiomas
		$languages = directory_map( $this->lang_path, TRUE );

		// validamos que este presente nuestro idioma de referencia 
		if ( ! in_array($this->reference, $languages ) )
		{
			$this->output('h2', 'Reference language "'.$this->reference.'" not found!', TRUE);
			exit;
		}

		// cargar la lista de archivos de idioma para el idioma de referencia
		$references = directory_map( $this->lang_path . '/' . $this->reference, TRUE );

		// procesar la lista
		foreach( $references as $reference )
		{
			// omitir los archivos no linguisticos en el directorio de idioma
			if ( strpos($reference, '_lang'.EXT) === FALSE )
			{
				continue;
			}

			// procesandolo
			$this->output('h2', 'Processing '.$this->reference . ' &raquo; ' .$reference);

			// cargar el archivo de idioma
			include $this->lang_path . '/' . $this->reference . '/' . $reference;

			// el archivo contiene cadenas de idioma
			if ( empty($lang) )
			{
				// archivo de idioma esta vacio o no está correctamente definido
				$this->output('h3', 'Language file doesn\'t contain any language strings. Skipping file!', TRUE);
				continue;
			}

			// almacenar las cadenas de idioma cargados
			$lang_ref = $lang;
			unset($lang);

			// bucle a traves de los idiomas disponibles
			foreach ( $languages as $language )
			{
				// omita el idioma de referencia
				if ( $language == $this->reference )
				{
					continue;
				}

				// archivo de idioma para comprobar
				$file = $this->lang_path . '/' . $language . '/' . $reference;

				// comprobar si existe el archivo de idioma para este idioma
				if ( ! file_exists( $file ) )
				{
					// archivo no encontrado
					$this->output('h3', 'Language file doesn\'t exist for the language '.$language.'!', TRUE);
				}
				else
				{
					// cargar el archivo para comparar
					include $file;

					// el archivo contiene cadenas de idioma 
					if ( empty($lang) )
					{
						// archivo de idioma esta vacio o no está correctamente definido
						$this->output('h3', 'Language file for the language '.$language.' doesn\'t contain any language strings!', TRUE);
					}
					else
					{
						// empezar a comparar
						$this->output('h3', 'Comparing with the '.$language.' version:');

						// no hay fallas
						$failures = 0;

						// empezar a comparar teclas de idioma
						foreach( $lang_ref as $key => $value )
						{
							if ( ! isset($lang[$key]) )
							{
								// reportar la clave que falta
								$this->output('', 'Missing language string "'.$key.'"', TRUE);

								// incrementar el contador de fallas
								$failures++;
							}
						}

						if ( ! $failures )
						{
							$this->output('', 'The two language files have matching strings.');
						}
					}

					// la matriz lang se elimina antes de la proxima consulta
					if ( isset($lang) )
					{
						unset($lang);
					}
				}
			}

		}

		$this->output('h2', 'Language file checking and validation completed');
	}

	// -----------------------------------------------------------------

	private function output($type = '', $line = '', $highlight = FALSE)
	{
		switch ($type)
		{
			case 'h1':
				$html = "<h1>{line}</h1>\n<hr />\n";
				break;

			case 'h2':
				$html = "<h2>{line}</h2>\n";
				break;

			case 'h3':
				$html = "<h3>&nbsp;&nbsp;&nbsp;{line}</h3>\n";
				break;

			default:
				$html = "&nbsp;&nbsp;&nbsp;&nbsp;&raquo;&nbsp;{line}<br />";
				break;
		}

		if ( $highlight )
		{
			$line = '<span style="color:red;font-weight:bold;">' . $line . '</span>';
		}

		echo str_replace('{line}', $line, $html);
	}
	// -----------------------------------------------------------------

}

/* End of file languagecheck.php */
/* Location: ./application/controllers/languagecheck.php */
