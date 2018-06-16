<?php
class Pagination {
	public $total = 0;
	public $page = 1;
	public $limit = 20;
	public $num_links = 3;
	public $url = '';
	public $text_first = '<i class="fa fa-angle-double-left" aria-hidden="true"></i>';
	public $text_last = '<i class="fa fa-angle-double-right" aria-hidden="true"></i>';
	public $text_next = '<i class="fal fa-arrow-right"></i>';
	public $text_prev = '<i class="fal fa-arrow-left"></i>';

	public function render() {
        $left_side_dots = false;
        $right_side_dots = false;
        $pagination_visible_step = 1;

		$total = $this->total;

		if ($this->page < 1) {
			$page = 1;
		} else {
			$page = $this->page;
		}

		if (!(int)$this->limit) {
			$limit = 3;
		} else {
			$limit = $this->limit;
		}

		$num_links = $this->num_links;
		$num_pages = ceil($total / $limit);

		$this->url = str_replace('%7Bpage%7D', '{page}', $this->url);

		$output = '<ul class="pagination justify-content-center">';

		if ($page > 1) {
			/*$output .= '<li class="pagin-first"><a href="' . str_replace(array('?page={page}', '&amp;page={page}'), '', $this->url) . '">' . $this->text_first . '</a></li>';*/

			if ($page - 1 === 1) {
                $output .= '<li class="page-item"><a class="page-link" href="' . str_replace(array('?page={page}', '&amp;page={page}'), '', $this->url) . '">' . $this->text_prev . '</a></li>';
			} else {
                $output .= '<li class="page-item"><a class="page-link" href="' . str_replace('{page}', $page - 1, $this->url) . '">' . $this->text_prev . '</a></li>';
			}
		}else{
            $output .= '<li class="page-item disabled"><span class="page-link">' . $this->text_prev . '</span></li>';
        }

		if ($num_pages > 1) {
			if ($num_pages <= $num_links) {
				$start = 1;
				$end = $num_pages;
			} else {
				$start = $page - floor($num_links / 2);
				$end = $page + floor($num_links / 2);

				if ($start < 1) {
					$end += abs($start) + 1;
					$start = 1;
				}

				if ($end > $num_pages) {
					$start -= ($end - $num_pages);
					$end = $num_pages;
				}
			}

            for ($i = $start; $i <= $end; $i++) {
                /*
                if (($i > $page+$pagination_visible_step) || ($i < $page-$pagination_visible_step)) {

                    if (($i > $page+$pagination_visible_step) && (!$left_side_dots)) {
                        $output .= '<li class="pagination-dots"><span>...</span></li>';
                        $left_side_dots = true;
                    }

                    if (($i < $page-$pagination_visible_step) && (!$right_side_dots)) {
                        $output .= '<li class="pagination-dots"><span>...</span></li>';
                        $right_side_dots = true;
                    }
                }else {
    				if ($page == $i) {
    					$output .= '<li class="active"><span>' . $i . '</span></li>';
    				} else {
    					if ($i === 1) {
                            $output .= '<li><a href="' . str_replace(array('?page={page}', '&amp;page={page}'), '', $this->url) . '">' . $i . '</a></li>';
    					} else {
    						$output .= '<li><a href="' . str_replace('{page}', $i, $this->url) . '">' . $i . '</a></li>';
    					}
    				}
                }*/

                if ($page == $i) {
                    $output .= '<li class="page-item active"><span class="page-link">' . $i . '<span class="sr-only">(current)</span></span></li>';
                } else {
                    if ($i === 1) {
                        $output .= '<li class="page-item"><a class="page-link" href="' . str_replace(array('?page={page}', '&amp;page={page}'), '', $this->url) . '">' . $i . '</a></li>';
                    } else {
                        $output .= '<li class="page-item"><a class="page-link" href="' . str_replace('{page}', $i, $this->url) . '">' . $i . '</a></li>';
                    }
                }
			}
		}

		if ($page < $num_pages) {
            $output .= '<li class="page-item"><a class="page-link" href="' . str_replace('{page}', $page + 1, $this->url) . '">' . $this->text_next . '</a></li>';
			/*$output .= '<li class="pagin-last"><a href="' . str_replace('{page}', $num_pages, $this->url) . '">' . $this->text_last . '</a></li>';*/
		}

		$output .= '</ul>';

		if ($num_pages > 1) {
			return $output;
		} else {
			return '';
		}
	}
}
