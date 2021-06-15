In this tutorial, I am going to give you an overview over how this effect works.
I was inspired by Firebelley Games' 2D liquid vial effect, it's also on YoutTube, you can find the link in the description.
However, I was going for a liquid effect that also includes the inertia of the liquid.
So I made this effect.
To simulate the inertia of the liquid, I assume that the surface of the liquid behaves as if it was connected to the string of a pendulum.
. I can show you in the example.

-> Visualize pendulum

So now we have a pendulum, and the surface of the liquid is connected to the "string" of the pendulum.
The angle between the string and the up direction is then fed into the shader.
And the shader takes care of rendering the liquid level, the surface, and the noise effects that you can see.

-> Omni graffle

So there are multiple layers that work together.
In front, there's the bottle itself, including the front part of the glass, with subtle lighting applied.
. You can leave this out if you don't have directional lighting or add normals to have Godot perform a light pass.

--> Mask

Then there is the mask texture that limits the effect to the bottle itself.
This texture is multiplied with a color to provide the liquid's color.
We're going to see this later in the video.
It also is used for the alpha channel, and outside the bottle, the alpha value is 0.
Inside, the alpha value is 1 in the middle and slightly lower at the edges and the bottom.
This is because the amount of liquid a ray of light goes through is less in these areas.
. It's also generally a good idea to make a mask less uniform to add some visual interest.
. But this depends on the cleanliness of the style you are going for.

--> Fill

And lastly, there's the fill texture.
The shader uses this texture, a fill proportion and an edge rotation value that we pass in to render the surface of the liquid.
. The edge rotation comes from the virtual pendulum that we've seen at the start.
Anyway, the fill texture is positioned by the shader as needed and is then multiplied with the mask.
This then results in a partially filled bottle.

-> Godot / Shader

Ok, let's have a look at the shader.