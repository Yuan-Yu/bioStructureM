function plot_order_parameter(mode_0,mode_1,mode_2,Exp_order_parameter,reduced_order_parameter_from_PCA)
o_exp = Exp_order_parameter;
o_0 = reduced_order_parameter_from_PCA(:,mode_0);
o_1 = reduced_order_parameter_from_PCA(:,mode_1);
o_2 = reduced_order_parameter_from_PCA(:,mode_2);

res_id_exp = 1:76;
res_id_0 = res_id_exp;
res_id_2 = res_id_exp;
res_id_1 = res_id_exp;

id_exp = find(~Exp_order_parameter);
id_0 = [19,37,38];
id_1 = [19,37,38];
id_2 = [19,37,38];

s_exp = plot(res_id_exp,o_exp,'bo');
hold on
s_0 = plot(res_id_0,o_0,'rx-');
hold on
s_1 = plot(res_id_1,o_1,'g.-');
hold on
s_2 = plot(res_id_2,o_2,'k+-');

o_exp(id_exp) = [];
o_0(id_0) = [];
o_1(id_1) = [];
o_2(id_2) = [];

res_id_exp(id_exp) = [];
res_id_0(id_0) = [];
res_id_1(id_1) = [];
res_id_2(id_2) = [];

set(s_exp,'xdata',res_id_exp,'ydata',o_exp);
set(s_0,'xdata',res_id_0,'ydata',o_0);
set(s_0,'xdata',res_id_0,'ydata',o_0);
set(s_1,'xdata',res_id_1,'ydata',o_1);
set(s_2,'xdata',res_id_2,'ydata',o_2);
end

