fs = 48000;
f_base = 500;
len_t = 0.04;
bitscale = 5;
len_alp = 5;
th = 179;

alp_to_tf_table = [%f, %f, %f, %f, %t
%f, %f, %f, %t, %f
%f, %f, %f, %t, %t
%f, %f, %t, %f, %f
%f, %f, %t, %f, %t
%f, %f, %t, %t, %f
%f, %f, %t, %t, %t
%f, %t, %f, %f, %f
%f, %t, %f, %f, %t
%f, %t, %f, %t, %f
%f, %t, %f, %t, %t
%f, %t, %t, %f, %f
%f, %t, %t, %f, %t
%f, %t, %t, %t, %f
%f, %t, %t, %t, %t
%t, %f, %f, %f, %f
%t, %f, %f, %f, %t
%t, %f, %f, %t, %f
%t, %f, %f, %t, %t
%t, %f, %t, %f, %f
%t, %f, %t, %f, %t
%t, %f, %t, %t, %f
%t, %f, %t, %t, %t
%t, %t, %f, %f, %f
%t, %t, %f, %f, %t
%t, %t, %f, %t, %f
%t, %t, %f, %t, %t
%t, %t, %t, %f, %f
%t, %t, %t, %f, %t
%t, %t, %t, %t, %f
%t, %t, %t, %t, %t
%f, %f, %f, %f, %f]

tf_to_alp_table = strsplit("ABCDEFGHIJKLMNOPQRSTUVWXYZ .,!?-")

exec("./encode.sci")
exec("./decoder.sci")
exec("./channel.sci")
