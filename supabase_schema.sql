-- Table to store TCC Cloud Clusters (Both Real and Simulated)
CREATE TABLE IF NOT EXISTS public.tcc_records (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ DEFAULT now(),
    lat FLOAT8 NOT NULL,
    lon FLOAT8 NOT NULL,
    size INTEGER, -- In km2
    intensity FLOAT8, -- Brightness Temp
    source TEXT DEFAULT 'simulated', -- 'real' or 'simulated'
    prediction_score FLOAT8, -- Confidence 0.0 - 1.0
    status TEXT -- 'Active', 'Developing', 'Dissipated'
);

-- Table to store AI Chat/Q&A Insights
CREATE TABLE IF NOT EXISTS public.ai_insights (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ DEFAULT now(),
    question TEXT,
    response TEXT,
    model_id TEXT
);

-- Enable Realtime for these tables
ALTER PUBLICATION supabase_realtime ADD TABLE tcc_records;
ALTER PUBLICATION supabase_realtime ADD TABLE ai_insights;

-- Basic Read-only RLS Policy (Allow anyone to read, restrict writes)
ALTER TABLE public.tcc_records ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public Read Access" ON public.tcc_records FOR SELECT USING (true);

ALTER TABLE public.ai_insights ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public Read Access" ON public.ai_insights FOR SELECT USING (true);
