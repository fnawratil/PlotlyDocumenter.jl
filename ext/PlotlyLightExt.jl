module PlotlyLightExt
    using HypertextLiteral
    using PlotlyDocumenter
    using PlotlyLight
    import PlotlyLight.JSON3
    
    const settings = if isdefined(PlotlyLight, :DEFAULT_SETTINGS) 
        # This is for PlotlyLight < v0.8
        PlotlyLight.DEFAULT_SETTINGS 
    else 
        PlotlyLight.settings
    end

    function PlotlyDocumenter.to_documenter(p::PlotlyLight.Plot; kwargs...)
        data = JSON3.write(p.data)
        layout = JSON3.write(merge(settings.layout, p.layout))
        config = JSON3.write(merge(settings.config, p.config))
        return PlotlyDocumenterPlot(data, layout, config, kwargs...)
    end
end