% Plot Figure 3: NZ yields term structure (using data from Reuters)

function plot_Fig_3(model)

% 3D Figure of Reuters yields
fn=figure; 
surf(model.maturities,model.dates,model.Yield)
colormap([127/255 1 212/255; 1 0.3 0])
view(-70.5,30)
xlabel('Maturities'); ylabel('Time'); zlabel('Yield (%)'); 
set(gca,'fontsize',12);
lambda = model.lambda;
if lambda == 0.0609
    saveas(fn,'figuresDATA/latex_yields3D', 'epsc'); 
else    % different values of lambda
    saveas(fn,'figuresDATA/different_lambda/latex_yields3D', 'epsc');
end

end