In this tutorial, I am going to give you an overview over how this effect works.
I was inspired by Firebelley Games' 2D liquid vial effect.
It's also on YouTube, you can find the link in the description.
However, I was going for a liquid effect that also includes the inertia of the liquid.
So I made this effect.

It's made up of three parts.

--> Show in Godot.

First, the bottle itself.
Behind it, the liquid.
And then, the pendulum.
The pendulum simply dictates how the liquid should behave.
It gives it the inertia it needs to look good.

-> Visualize pendulum

The code on the liquid takes the angle of the pendulum and feeds it into the liquid shader.

--> Shader

This is the visual shader for the liquid.
The shader takes care of rendering the liquid level, the surface, and the noise effects that you can see.
I'm going to go over it at the end.
First let me take the effect apart and explain its layers.

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
It's quite simple:
First of all, we have the two texture inputs.
One is the mask, and one is the fill texture.
There are three distinct areas of the shader:

Here we multiply the mask with the color.
The rest of the shader is concerned with the alpha.
The whole bottom is concerned with adding visual interest to the effect, so adds some noise.
In this case I am using a cellular noise 3d.
You can use any other type of noise of course.
The upper left area is concerned with modifying the UV for the fill texture.

--> Example set edge rotation to 0.5.

See how the fill texture rotates?
But it's not that simple, because if it would just rotate, it would be too thin for the bottle.

-> Omni

That's why it is also stretched sideways.
The thinner the bottle, the more pronounced this stretching effect.

-> Godot

Now to finish up, let's look at the pendulum code.
As a base, I've adapted NeZvers' pendulum code from their video, you can find the link in the description.
What it essentially does is simulate this pendulum.

--> Show example.

In the Liquid node, I am then taking this angle, and passing it to the shader.