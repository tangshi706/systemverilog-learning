//参考：https://blog.csdn.net/gsjthxy/article/details/107432245
//https://blog.csdn.net/gsjthxy/article/details/107375518
/* module tb;

rand logic [31:0] addr[0:4];
//integer addr[0:4] = {80,82,84,86,88};
constraint c1{ 
				addr inside {80,82,84,86,88};
}

initial begin

repeat(100)
//fork
$display("addr0=%0d,addr1=%0d,addr2=%0d,addr3=%0d,addr4=%0d,"addr[0],addr[1],addr[2],addr[3],addr[4]);
/* APB_LITE_WRITE0(addr[0],32'h1234_5678);
APB_LITE_WRITE1(addr[1],32'h6666_6666);
APB_LITE_WRITE2(addr[2],32'h8888_8888);
APB_LITE_WRITE3(addr[3],32'h9999_9999);
APB_LITE_WRITE4(addr[4])32'h5555_5555; 
//join_any
#200 $finish();
end
endmodule */


/* class queue_rand;
  rand bit [7:0] qu[$];

  constraint size_c  { qu.size() inside {[4:10]}; }
  function void display();
    $display("qu size is = %0d",qu.size());
    $display("qu = %p",qu);
  endfunction
endclass

 

program queue_randomization;
  queue_rand pkt;
  initial begin
    pkt = new();
    pkt.randomize();
    pkt.display();   
  end

endprogram  */
//产生的结果：
//Simulator Output
//qu size is = 7
//qu = '{'h88, 'h9b, 'h9a, 'h10, 'h5f, 'hde, 'h84}

class fs_array;

  rand bit [7:0] array1[6];
  //constraint array_c { foreach(array1[i]) array1[i] == i;}
  //constraint cst_d { foreach(array1[j])  array1[j] > array1[j+1];}

  //constraint array_c { foreach(array1[i]) array1[i] inside {1,2,3,4,5};}
  constraint array_c { foreach(array1[i]) array1[i] == i;}


  //constraint cst_d { foreach(array1[j])  array1[j] > array1[j+1];}

  function void post_randomize();
    array1.shuffle();  
  endfunction
  
  function void display();
    $display("array1 = %p",array1);

    $display("array1[0] = %p",array1[0]);
    $display("array1[1] = %p",array1[1]);
    $display("array1[2] = %p",array1[2]);
    $display("array1[3] = %p",array1[3]);
    $display("array1[4] = %p",array1[4]);
    $display("array1[5] = %p",array1[5]);
  endfunction
  
endclass

 

program fixedsize_array_randomization;

  fs_array pkt;

  initial begin
  repeat(10)
  begin
    pkt = new();
    pkt.randomize();
    pkt.display();   
	end
	//#1ns $finish();
  end

endprogram 
