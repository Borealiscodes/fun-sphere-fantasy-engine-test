pub struct AudioPacket {
    pub amplitude: f64,
    pub variance: f64,
}

pub fn process_pcm_frame(data: &[f32]) -> AudioPacket {
    let rms = (data.iter().map(|x| x * x).sum::<f32>() / data.len() as f32).sqrt() as f64;

    let mean = data.iter().copied().sum::<f32>() / data.len() as f32;
    let variance = data.iter().map(|x| {
        let d = *x - mean;
        d * d
    }).sum::<f32>() / data.len() as f32;

    AudioPacket {
        amplitude: rms,
        variance: variance as f64,
    }
}
