<?php

namespace Admin\Controller;

use Common\Controller\AdminbaseController;
class GoodsController extends AdminbaseController {

	private $gdl;
	private $scoreCols = array(
		array( 20, '商品名称', 'CCFFCC' ),
		array( 30, '商品规格', 'CCFFCC' ),
		array( 30, '条形码', 'CCFFCC' )
	);

	function _initialize() {
		parent::_initialize();

		$this->gdl = D( 'Goods' );
	}

	function index() {
		$status = trim($_POST['status'])  ;
		$keyword = trim( $_POST['keyword'] );
		
		$this->assign('status',$status);
		$this->assign( 'keyword', $keyword );
		$where = array();
		if ($status) $where['status'] = (int)$status;
		if ( !empty($keyword) ) {
			$where['name|barcode'] = array('like',"%$keyword%");
		}
		$count = $this->gdl->where($where)->count();
		$page = $this->page($count, 20);
		$list = $this->gdl->where($where)->limit( $page->firstRow, $page->listRows )->order("modify_time desc")->select();
		$this->assign("page", $page->show('Admin'));
		$this->assign( 'list', $list );
		$this->display();
	}
	
	function getGoods() {
		if (IS_AJAX){
			$barcode = I('barcode');
			$goods = $this->gdl->where(array('barcode' => $barcode))->find();
			$this->ajaxReturn($goods);
		}
	}
	
	function add() {
		if ( IS_POST ) {
			$_POST['content'] = htmlspecialchars_decode( $_POST['content'] );
			$_POST['goods_pic'] = sp_asset_relative_url( $_POST['goods_pic'] );
			$_POST['modify_time'] = date('Y-m-d H:i:s',time());
			
			$goods = $this->gdl->where(array('barcode' => $_POST['barcode']))->find();
			if ( $goods ) {
				if( ($this->gdl->where(array('barcode' => $_POST['barcode']))->save($_POST)) !== false ){
					$this->success( '添加成功！', U( 'goods/index' ) );
				} else {
					$this->error( '添加失败！' );
				}
			} else {
				if ( ( $this->gdl->add( $_POST )) !== false ) {
					$this->success( '添加成功！', U( 'goods/index' ) );
				} else {
					$this->error( '添加失败！' );
				}
			}
		}
		else {
			$this->display();
		}
	}

	function edit() {
		if ( IS_POST ) {
			$id = (int)$_POST['id'];

			$_POST['content'] = htmlspecialchars_decode( $_POST['content'] );
			$_POST['goods_pic'] = sp_asset_relative_url( $_POST['goods_pic'] );
			$_POST['modify_time'] = date('Y-m-d H:i:s',time());
			
			if( $this->gdl->where( array( 'id'=>$id ) )->save( $_POST ) !== false ) $this->success( '修改成功！', U( 'goods/index' ) );
			else $this->error( '修改失败！' );
			
		}
		else {
			$id = intval( I( 'get.id' ) );
			$goods = $this->gdl->where( array( 'id' => $id ) )->find();
			$this->assign( $goods );

			$this->display();
		}
	}
	
	function account() {
		$this->display();
	}

	function delete() {
		if ( isset( $_POST['ids'] ) ) {
			$ids = implode( ',', $_POST['ids'] );
			if ( $this->gdl->where( "id in ($ids)" )->delete() !== false ) {
				$this->success( '删除成功！' );
			} else {
				$this->error( '删除失败！' );
			}
		} else {
			$id = intval( I( 'get.id' ) );
			if ( $this->gdl->delete( $id ) !== false ) {
				$this->success( '删除成功！' );
			} else {
				$this->error( '删除失败！' );
			}
		}
	}

	function toggle() {
		if ( isset( $_POST['ids'] ) && $_GET['display'] ) {
			$ids = implode( ',',  $_POST['ids'] );
			$data['status'] = 1;
			if ( $this->gdl->where( "id in ($ids)" )->save( $data ) !== false ) {
				$this->success( '显示成功！' );
			} else {
				$this->error( '显示失败！' );
			}
		}
		if ( isset( $_POST['ids'] ) && $_GET['hide'] ) {
			$ids = implode( ',', $_POST['ids'] );
			$data['status'] = 0;
			if ( $this->gdl->where( "id in ($ids)" )->save( $data ) !== false ) {
				$this->success( '隐藏成功！' );
			} else {
				$this->error( '隐藏失败！' );
			}
		}
	}

	function ban() {
		$id = intval( $_GET['id'] );
		$data['status'] = 0;
		if ( $id ) {
			if ( $this->gdl->where( "id in ($id)" )->save( $data ) ) {
				$this->success( '隐藏成功！' );
			} else {
				$this->error( '隐藏失败！' );
			}
		} else {
			$this->error( '数据传入失败！' );
		}
	}

	function cancelban() {
		$id = intval( $_GET['id'] );
		$data['status'] = 1;
		if ( $id ) {
			if ( $this->gdl->where( "id in ($id)" )->save( $data ) ) {
				$this->success( '显示成功！' );
			} else {
				$this->error( '显示失败！' );
			}
		} else {
			$this->error( '数据传入失败！' );
		}
	}

	public function listorders() {
		$status = parent::_listorders( $this->gdl );
		if ( $status ) {
			$this->success( '排序更新成功！' );
		} else {
			$this->error( '排序更新失败！' );
		}
	}

	function goods_upload() {

		if ( IS_POST ) {
			$uploadConfig = array(
				'FILE_UPLOAD_TYPE' => sp_is_sae() ? 'Sae' : 'Local',
				'rootPath' => './'.C( 'UPLOADPATH' ),
				'savePath' => './excel/',
				'saveName' => array( 'uniqid', '' ),
				'exts' => array( 'xls', 'xlsx' ),
				'autoSub' => false
			);
			$upload = new \Think\Upload( $uploadConfig );
			$info = $upload->upload();
			$file = './'.C( 'UPLOADPATH' ).$info['file']['savepath'].$info['file']['savename'];

			require_once 'today/excel/PHPExcel.php';
			require_once 'today/excel/PHPExcel/IOFactory.php';
			require_once 'today/excel/PHPExcel/Reader/Excel5.php';
			require_once 'today/excel/PHPExcel/Reader/Excel2007.php';
			require_once 'today/excel/PHPExcel.php';

			$reader = \PHPExcel_IOFactory::createReader( end( explode( '.', $file ) ) == 'xls' ? 'Excel5' : 'Excel2007' );
			$obj = $reader->load( $file );
			$sheet = $obj->getSheet(0);
			$rowCount = $sheet->getHighestRow();
			$colCount = $sheet->getHighestColumn();
			$realRowCount = 0;
			$importCount = 0;

			$list = array();
			for ( $i = 2; $i <= $rowCount; $i++ ) {
				$name = trim( $sheet->getCell( 'A'.$i )->getValue() );
				$norms = trim( $sheet->getCell( 'B'.$i )->getValue() );
				$barcode = trim( $sheet->getCell( 'C'.$i )->getValue() );

				if ( empty( $name ) || empty( $barcode ) ) continue;
				$realRowCount++;
				$importCount++;

				$goodsObj = $this->gdl->where( array( 'barcode' => $barcode ) )->find();
				if ( $goodsObj ) {
					//存在
					$this->gdl->where( array( 'barcode' => $barcode ) )->save( array( 'name' => $name, 'norms' => $norms, 'modify_time'=> date('Y-m-d H:i:s',time()) ) );  //更新
				}
				else {
					//不存在
					$this->gdl->add( array( 'name' => $name, 'norms' => $norms, 'barcode' => $barcode, 'modify_time'=> date('Y-m-d H:i:s',time()) ) );
				}
			}

			@unlink( $file );
			$this->success( '成功导入'.$importCount.'条商品记录', U( 'goods/index' ) );
		}

		$this->display();
	}
	
}